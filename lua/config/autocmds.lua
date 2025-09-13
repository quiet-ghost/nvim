-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("ShowkeysToggle")
--   end,
--   desc = "Auto-start showkeys on Neovim startup",
-- })
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
      "import javafx.scene.control.Label;",
      "import javafx.scene.layout.StackPane;",
      "import javafx.stage.Stage;",
      "",
      "public class " .. filename .. " extends Application {",
      "    @Override",
      "    public void start(Stage primaryStage) {",
      "        Label label = new Label(\"Hello JavaFX!\");",
      "        ",
      "        StackPane root = new StackPane();",
      "        root.getChildren().add(label);",
      "        ",
      "        Scene scene = new Scene(root, 400, 300);",
      "        primaryStage.setTitle(\"" .. filename .. "\");",
      "        primaryStage.setScene(scene);",
      "        primaryStage.show();",
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
