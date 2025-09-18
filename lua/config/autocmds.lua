vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.java",
  callback = function()
    local filename = vim.fn.expand("%:t:r")
    local lines = {
      "public class " .. filename .. " {",
      "    ",
      "}",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, { 2, 4 })
  end,
})

-- JavaFX template for files ending with FX.java or containing JavaFX
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*FX.java",
  callback = function()
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
      "    }",
      "    ",
      "    public static void main(String[] args) {",
      "        launch(args);",
      "    }",
      "}",
    }
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, { 11, 8 })
  end,
})
