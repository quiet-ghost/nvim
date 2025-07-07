local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local M = {}

-- Helper function to run tmux commands
local function tmux_cmd(cmd)
  local handle = io.popen("/usr/bin/tmux " .. cmd .. " 2>/dev/null")
  if not handle then return "" end
  local result = handle:read("*a")
  handle:close()
  return result or ""
end

-- Session switcher/manager
function M.sessions()
  local sessions_output = tmux_cmd("list-sessions")
  
  if sessions_output == "" then
    print("No tmux sessions found")
    return
  end
  
  local sessions = {}
  for line in sessions_output:gmatch("[^\r\n]+") do
    local session_name = line:match("^([^:]+):")
    local windows_count = line:match("(%d+) windows?")
    local is_attached = line:match("%(attached%)")
    
    if session_name then
      table.insert(sessions, {
        name = session_name,
        display = line,
        windows_count = windows_count or "0",
        attached = is_attached and true or false,
      })
    end
  end
  
  if #sessions == 0 then
    print("No sessions found")
    return
  end
  
  pickers.new({}, {
    prompt_title = "tmux sessions",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      horizontal = {
        preview_width = 0.75,  -- Give more space to preview
        prompt_position = "bottom",
      }
    },
    finder = finders.new_table({
      results = sessions,
      entry_maker = function(entry)
        -- Simple indicators
        local indicator = entry.attached and "● " or "○ "
        -- Clean display with just session name
        local short_display = indicator .. entry.name
        return {
          value = entry.name,
          display = short_display,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_termopen_previewer({
      title = "Session Preview",
      get_command = function(entry, status)
        local session_name = entry.value
        return {'/usr/bin/tmux', 'attach-session', '-t', session_name, '-r'}
      end
    }),
    attach_mappings = function(prompt_bufnr, map)
      -- Switch to session (Enter)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        local session_name = selection.value
        os.execute("/usr/bin/tmux switch-client -t '" .. session_name .. "'")
        print("Switched to session: " .. session_name)
      end)
      
      -- Kill session (Ctrl+d)
      map("i", "<C-d>", function()
        local selection = action_state.get_selected_entry()
        local session_name = selection.value
        
        vim.ui.input({ prompt = "Kill session '" .. session_name .. "'? (y/N): " }, function(input)
          if input and input:lower() == "y" then
            os.execute("/usr/bin/tmux kill-session -t '" .. session_name .. "'")
            print("Killed session: " .. session_name)
            actions.close(prompt_bufnr)
            -- Refresh the picker
            vim.defer_fn(function() M.sessions() end, 100)
          end
        end)
      end)
      
      -- Rename session (Ctrl+r)
      map("i", "<C-r>", function()
        local selection = action_state.get_selected_entry()
        local session_name = selection.value
        
        vim.ui.input({ prompt = "Rename session '" .. session_name .. "' to: " }, function(new_name)
          if new_name and new_name ~= "" then
            os.execute("/usr/bin/tmux rename-session -t '" .. session_name .. "' '" .. new_name .. "'")
            print("Renamed session to: " .. new_name)
            actions.close(prompt_bufnr)
            -- Refresh the picker
            vim.defer_fn(function() M.sessions() end, 100)
          end
        end)
      end)
      
      -- Create new session (Ctrl+n)
      map("i", "<C-n>", function()
        vim.ui.input({ prompt = "New session name: " }, function(session_name)
          if session_name and session_name ~= "" then
            os.execute("/usr/bin/tmux new-session -d -s '" .. session_name .. "'")
            print("Created session: " .. session_name)
            actions.close(prompt_bufnr)
            -- Refresh the picker
            vim.defer_fn(function() M.sessions() end, 100)
          end
        end)
      end)
      
      return true
    end,
  }):find()
end

-- Project sessionizer (like your terminal tmux-sessionizer)
function M.sessionizer()
  local dirs_output = tmux_cmd("run-shell 'find ~/dev ~/personal -mindepth 1 -maxdepth 3 -type d 2>/dev/null'")
  
  if dirs_output == "" then
    print("No directories found")
    return
  end
  
  local directories = {}
  for dir in dirs_output:gmatch("[^\r\n]+") do
    if dir and dir ~= "" then
      local display_name = vim.fn.fnamemodify(dir, ":t") .. " (" .. vim.fn.fnamemodify(dir, ":h") .. ")"
      table.insert(directories, {
        path = dir,
        display = display_name,
        name = vim.fn.fnamemodify(dir, ":t"),
      })
    end
  end
  
  if #directories == 0 then
    print("No directories found")
    return
  end
  
  pickers.new({}, {
    prompt_title = "tmux sessionizer",
    finder = finders.new_table({
      results = directories,
      entry_maker = function(entry)
        return {
          value = entry.path,
          display = entry.display,
          ordinal = entry.name,
          name = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = previewers.new_buffer_previewer({
      title = "Directory Contents",
      define_preview = function(self, entry, status)
        local dir_path = entry.value
        local files_output = vim.fn.system("ls -la '" .. dir_path .. "' 2>/dev/null")
        
        local lines = {"Directory: " .. dir_path, ""}
        if files_output and files_output ~= "" then
          for line in files_output:gmatch("[^\r\n]+") do
            table.insert(lines, line)
          end
        else
          table.insert(lines, "Directory is empty or inaccessible")
        end
        
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        local dir_path = selection.value
        local session_name = selection.name:gsub("%.", "_")
        
        -- Check if session already exists
        local existing = tmux_cmd("has-session -t '" .. session_name .. "'")
        if vim.v.shell_error == 0 then
          -- Session exists, switch to it
          os.execute("/usr/bin/tmux switch-client -t '" .. session_name .. "'")
          print("Switched to existing session: " .. session_name)
        else
          -- Create new session
          os.execute("/usr/bin/tmux new-session -d -s '" .. session_name .. "' -c '" .. dir_path .. "'")
          os.execute("/usr/bin/tmux switch-client -t '" .. session_name .. "'")
          print("Created and switched to session: " .. session_name)
        end
      end)
      
      return true
    end,
  }):find()
end

return M