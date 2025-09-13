local M = {}

function M.compile_and_run()
  local file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")
  local classname = vim.fn.expand("%:t:r")
  local dir = vim.fn.expand("%:p:h")
  
  if not filename:match("%.java$") then
    vim.notify("Not a Java file!", vim.log.levels.ERROR)
    return
  end
  
  vim.cmd("w")
  
  -- Check if we're in tmux
  local in_tmux = os.getenv("TMUX") ~= nil
  
  if in_tmux then
    -- Read file to check if it's JavaFX and find main class
    local file_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local is_javafx = file_content:match("import javafx") or file_content:match("extends Application")
    
    -- Find the class that contains the main method
    local main_class = classname  -- Default to filename without extension
    
    -- Look for public static void main
    local main_pattern = "public%s+static%s+void%s+main"
    local main_match = file_content:match(main_pattern)
    
    if main_match then
      -- Find the class that contains main method
      -- Split content into lines and work backwards from main method
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local main_line = 0
      
      -- Find line with main method
      for i, line in ipairs(lines) do
        if line:match(main_pattern) then
          main_line = i
          break
        end
      end
      
      -- Search backwards for class declaration
      if main_line > 0 then
        for i = main_line, 1, -1 do
          local class_match = lines[i]:match("^%s*[public%s]*class%s+([%w_]+)")
          if class_match then
            main_class = class_match
            break
          end
        end
      end
    end
    
    local javac_path = "/usr/lib/jvm/liberica-jdk-17-full/bin/javac"
    local java_path = "/usr/lib/jvm/liberica-jdk-17-full/bin/java"
    
    if is_javafx then
      -- JavaFX program - run in background pane
      local tmux_cmd = string.format(
        [[tmux split-window -h -l 20%% "cd '%s' && %s %s && %s %s; echo 'Press Enter to close...'; read"]],
        dir,
        javac_path,
        filename,
        java_path,
        main_class  -- Use detected main class
      )
      vim.fn.system(tmux_cmd)
      vim.notify("JavaFX running (class: " .. main_class .. ")", vim.log.levels.INFO)
    else
      -- Regular Java program - run in interactive pane
      local tmux_cmd = string.format(
        [[tmux split-window -h -l 30%% "cd '%s' && %s %s && echo '--- Running %s ---' && %s %s; echo && echo 'Press Enter to close...'; read"]],
        dir,
        javac_path,
        filename,
        main_class,  -- Use detected main class for display
        java_path,
        main_class   -- Use detected main class for execution
      )
      vim.fn.system(tmux_cmd)
      vim.notify("Java running (class: " .. main_class .. ")", vim.log.levels.INFO)
    end
  else
    vim.notify("Not in tmux! Run from terminal instead.", vim.log.levels.ERROR)
  end
end

function M.compile_only()
  local file = vim.fn.expand("%:p")
  local filename = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")
  
  if not filename:match("%.java$") then
    vim.notify("Not a Java file!", vim.log.levels.ERROR)
    return
  end
  
  vim.cmd("w")
  
  -- Use Liberica javac for consistency
  local compile_cmd = string.format(
    "cd %s && /usr/lib/jvm/liberica-jdk-17-full/bin/javac %s",
    vim.fn.shellescape(dir),
    vim.fn.shellescape(filename)
  )
  
  vim.cmd("split | terminal " .. compile_cmd)
  vim.cmd("resize 10")  -- Make it smaller since it's just for error checking
end

return M
