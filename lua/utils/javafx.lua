local M = {}

-- Helper function to find pom.xml in current or parent directories
local function find_pom_xml(start_dir)
  local dir = start_dir
  local home = vim.fn.expand("~")

  while dir ~= "/" and dir ~= home do
    local pom_path = dir .. "/pom.xml"
    if vim.fn.filereadable(pom_path) == 1 then
      return dir, pom_path
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil, nil
end

-- Helper function to check if pom.xml contains JavaFX dependencies
local function is_javafx_maven_project(pom_path)
  local file = io.open(pom_path, "r")
  if not file then
    return false
  end

  local content = file:read("*all")
  file:close()

  -- Check for JavaFX dependencies or plugins
  return content:match("javafx") ~= nil
end

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

  if not in_tmux then
    vim.notify("Not in tmux! Run from terminal instead.", vim.log.levels.ERROR)
    return
  end

  -- Check for Maven project
  local maven_dir, pom_path = find_pom_xml(dir)

  if maven_dir and pom_path and is_javafx_maven_project(pom_path) then
    -- Maven JavaFX project - use mvn javafx:run
    vim.notify("Maven JavaFX project detected - running with mvn", vim.log.levels.INFO)

    local tmux_cmd = string.format(
      [[tmux split-window -h -l 20%% "cd '%s' && echo 'Running Maven JavaFX project...' && mvn clean javafx:run; echo && echo 'Press Enter to close...'; read"]],
      maven_dir
    )
    vim.fn.system(tmux_cmd)
    vim.notify("Maven JavaFX running from " .. maven_dir, vim.log.levels.INFO)
  else
    -- Single file JavaFX or regular Java - use existing logic
    local file_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local is_javafx = file_content:match("import javafx") or file_content:match("extends Application")

    -- Find the class that contains the main method
    local main_class = classname -- Default to filename without extension

    -- Look for public static void main
    local main_pattern = "public%s+static%s+void%s+main"
    local main_match = file_content:match(main_pattern)

    if main_match then
      -- Find the class that contains main method
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
      -- Single file JavaFX program - run in background pane
      local tmux_cmd = string.format(
        [[tmux split-window -h -l 20%% "cd '%s' && %s %s && %s %s; echo 'Press Enter to close...'; read"]],
        dir,
        javac_path,
        filename,
        java_path,
        main_class
      )
      vim.fn.system(tmux_cmd)
      vim.notify("JavaFX running (single file, class: " .. main_class .. ")", vim.log.levels.INFO)
    else
      -- Regular Java program - run in interactive pane
      local tmux_cmd = string.format(
        [[tmux split-window -h -l 30%% "cd '%s' && %s %s && echo '--- Running %s ---' && %s %s; echo && echo 'Press Enter to close...'; read"]],
        dir,
        javac_path,
        filename,
        main_class,
        java_path,
        main_class
      )
      vim.fn.system(tmux_cmd)
      vim.notify("Java running (class: " .. main_class .. ")", vim.log.levels.INFO)
    end
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

  -- Check for Maven project
  local maven_dir, pom_path = find_pom_xml(dir)

  if maven_dir and pom_path then
    -- Maven project - use mvn compile
    vim.notify("Maven project detected - compiling with mvn", vim.log.levels.INFO)

    local compile_cmd = string.format("cd %s && mvn compile", vim.fn.shellescape(maven_dir))

    vim.cmd("split | terminal " .. compile_cmd)
    vim.cmd("resize 10")
  else
    -- Single file - use javac directly
    local compile_cmd = string.format(
      "cd %s && /usr/lib/jvm/liberica-jdk-17-full/bin/javac %s",
      vim.fn.shellescape(dir),
      vim.fn.shellescape(filename)
    )

    vim.cmd("split | terminal " .. compile_cmd)
    vim.cmd("resize 10")
  end
end

function M.insert_template()
  local filename = vim.fn.expand("%:t:r")
  local lines = {
    "import javafx.application.Application;",
    "import javafx.scene.Scene;",
    "import javafx.stage.Stage;",
    "",
    "public class " .. filename .. " extends Application {",
    "    @Override",
    "    public void start(Stage primaryStage) {",
    "",
    "     Scene scene = new Scene();",
    "     primaryStage.setTitle();",
    "     primaryStage.setScene(scene);",
    "     primaryStage.show();",
    "    }",
    "    ",
    "    public static void main(String[] args) {",
    "        launch(args);",
    "    }",
    "}",
  }
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  -- Position cursor inside start method
  vim.api.nvim_win_set_cursor(0, { 10, 8 })
end

return M
