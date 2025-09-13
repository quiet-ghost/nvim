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
    -- Read file to check if it's JavaFX
    local file_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local is_javafx = file_content:match("import javafx") or file_content:match("extends Application")
    
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
        classname
      )
      vim.fn.system(tmux_cmd)
      vim.notify("JavaFX running in tmux pane", vim.log.levels.INFO)
    else
      -- Regular Java program - run in interactive pane
      local tmux_cmd = string.format(
        [[tmux split-window -h -l 30%% "cd '%s' && %s %s && echo '--- Running %s ---' && %s %s; echo && echo 'Press Enter to close...'; read"]],
        dir,
        javac_path,
        filename,
        classname,
        java_path,
        classname
      )
      vim.fn.system(tmux_cmd)
      vim.notify("Java program running in tmux pane", vim.log.levels.INFO)
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
