# QuietGhost's Neovim Configuration

Welcome to my Neovim configuration! This setup is designed for productivity and seamless integration with tmux, featuring a modern plugin ecosystem managed by `lazy.nvim`. It supports development in multiple languages including Python, SQL, C++, JavaScript, TypeScript, HTML, CSS, React, Next.js, TailwindCSS, and Lua, with a sleek custom theme (a mix of Material and Andromeda).

## Features

- **Plugin Management**: Uses `lazy.nvim` for efficient plugin loading.
- **Fuzzy Finding**: `telescope.nvim` with `telescope-fzf-native.nvim` for fast fuzzy searching.
- **Debugging**: `nvim-dap` with `nvim-dap-ui` for debugging Python, JavaScript/TypeScript, and C++.
- **LSP and Autocompletion**: `nvim-cmp` with LSP support for multiple languages, enhanced by `fidget.nvim` for LSP status updates.
- **Syntax Highlighting**: `nvim-treesitter` for advanced syntax highlighting and code navigation.
- **Code Navigation**: `flash.nvim` for quick cursor jumping, `harpoon` for file navigation.
- **Git Integration**: `gitsigns.nvim` for Git signs, `lazygit.nvim` for a Git UI.
- **Diagnostics**: `trouble.nvim` for a diagnostics overview.
- **Tmux Integration**: `vim-tmux-navigator` for seamless navigation between Neovim and tmux panes.
- **Productivity**: `todo-comments.nvim` for highlighting TODOs, `mini.nvim` for autopairs and text objects, `bufferline.nvim` for buffer management.
- **Formatting**: `conform.nvim` for code formatting.
- **Keybinding Discoverability**: `which-key.nvim` for a keybinding cheat sheet.

## Prerequisites

- **Neovim**: Version 0.9.0 or higher.
- **Tmux**: For tmux integration (optional but recommended).
- **Node.js**: For JavaScript/TypeScript LSP and DAP.
- **Python**: For Python LSP and DAP (`pip install debugpy`).
- **C++ Debugger**: Install `cpptools` via `:MasonInstall cpptools` for C++ debugging.
- **Build Tools**: For `telescope-fzf-native.nvim`:
  - Linux: `sudo apt install build-essential cmake`
  - macOS: `brew install cmake`
  - Windows: Install `cmake` and `mingw` via `scoop`.
- **Tmux Plugins**: If using tmux, install `tmux-plugins/tpm` and `dracula/tmux` (see `~/.tmux.conf` below).

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/quiet-ghost/nvim.git ~/.config/nvim
   ```

2. **Start Neovim**:

   ```bash
   nvim
   ```

   `lazy.nvim` will automatically install and sync all plugins on the first launch.

3. **Install Language Servers and Debuggers**:

   - Run `:Mason` to install LSP servers (e.g., `pylsp` for Python, `tsserver` for JavaScript/TypeScript).

   - Install `debugpy` for Python debugging:

     ```bash
     pip install debugpy
     ```

   - Install `vscode-node-debug2` for JavaScript/TypeScript debugging:

     ```bash
     mkdir -p ~/.local/share/nvim/dap
     cd ~/.local/share/nvim/dap
     git clone https://github.com/microsoft/vscode-node-debug2.git
     cd vscode-node-debug2
     npm install
     npm run build
     ```

   - Install `cpptools` for C++ debugging:

     ```vim
     :MasonInstall cpptools
     ```

4. **Set Up Tmux (Optional)**:

   - Install tmux:

     ```bash
     sudo apt install tmux  # On Ubuntu/Debian
     ```

   - Install tmux plugin manager (TPM):

     ```bash
     git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
     ```

   - Use the provided `~/.tmux.conf` from the repository:

     ```bash
     cp ~/.config/nvim/.tmux.conf ~/
     ```

   - Source the tmux configuration:

     ```bash
     tmux source-file ~/.tmux.conf
     ```

   - Install tmux plugins:

     ```tmux
     Prefix + I  # Default prefix is C-Space
     ```

## Directory Structure

- `lua/config/`: Core configuration files.
  - `lazy.lua`: Lazy.nvim setup.
  - `options.lua`: General Neovim options.
- `lua/plugins/`: Plugin configurations.
  - `telescope.lua`: Telescope setup with `telescope-fzf-native.nvim`.
  - `dap.lua`: Debugging with `nvim-dap` and `nvim-dap-ui`.
  - `tmux-navigator.lua`: Tmux navigation.
  - And more for other plugins.
- `.tmux.conf`: Tmux configuration for seamless Neovim integration.

## Keybindings

Keybindings are defined in `lua/config/keymaps.lua`. Some highlights:

- **Leader Key**: `<Space>`
- **Telescope**:
  - `<leader>ff`: Find files.
  - `<leader>fg`: Live grep.
  - `<leader>fb`: Buffers.
  - `<leader>fh`: Help tags.
- **Debugging**:
  - `<leader>db`: Toggle breakpoint.
  - `<leader>dc`: Start/continue debugging.
  - `<leader>di`: Step into.
  - `<leader>do`: Step over.
  - `<leader>dO`: Step out.
  - `<leader>dt`: Terminate debugging.
- **Tmux Navigation**:
  - `<C-h/j/k/l>`: Navigate between Neovim splits and tmux panes.
  - `<C-\\>`: Go to the previous pane.
- **Git**:
  - `<leader>lg`: Open LazyGit.
  - `<leader>gs`: Stage hunk (via `gitsigns.nvim`).
- **Diagnostics**:
  - `<leader>lt`: Toggle Trouble diagnostics.
  - `<leader>lw`: Workspace diagnostics.
- **Harpoon**:
  - `<leader>a`: Add file to Harpoon.
  - `<leader>ht`: Toggle Harpoon menu.
- **Mini.nvim**:
  - `daf`: Delete around function (via `mini.ai`).
  - Autopairs enabled for `()`, `{}`, etc. (via `mini.pairs`).

## Supported Languages

- **Python**: LSP via `pylsp`, debugging with `debugpy`.
- **JavaScript/TypeScript**: LSP via `tsserver`, debugging with `vscode-node-debug2`.
- **C++**: LSP via `clangd`, debugging with `cpptools`.
- **HTML/CSS**: LSP via `html` and `cssls`.
- **React/Next.js**: Enhanced with `nvim-ts-autotag`.
- **SQL**: Syntax highlighting via `nvim-treesitter`.
- **Lua**: LSP via `lua_ls` for Neovim plugin development.

## Customization

- **Theme**: Uses `tokyonight` (configured in `lua/plugins/tokyonight.lua`).
  - Change the theme by modifying the `colorscheme` command in `lua/config/options.lua`.
- **Plugins**: Add or remove plugins in `lua/plugins/`.
- **Keybindings**: Customize keybindings in `lua/config/keymaps.lua`.

## Contributing

Feel free to fork this repository and submit pull requests with improvements or fixes. Issues and feature requests are welcome!

## License

This configuration is licensed under the MIT License. See LICENSE for details.
