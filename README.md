# Neovim Configuration with LazyVim

This repository contains my personal Neovim configuration, built on top of [LazyVim](https://www.lazyvim.org/), a modern and modular Neovim configuration framework. It is designed to be lightweight, extensible, and tailored to my workflow, with a focus on productivity and ease of use.

## Features

- **LazyVim Base**: Leverages LazyVim's sensible defaults and plugin management for a streamlined setup.
- **Custom Plugins**: Includes plugins for code completion, syntax highlighting, file navigation, and more, configured to suit my preferences.
- **Keybindings**: Personalized keymappings for efficient editing and navigation.
- **Theme**: Configured with a clean, distraction-free theme for comfortable coding sessions.
- **LSP Support**: Integrated Language Server Protocol (LSP) for robust autocompletion, diagnostics, and code navigation.
- **Modular Structure**: Organized configuration files for easy customization and maintenance.

## Prerequisites

To use this configuration, you need:

- [Neovim](https://neovim.io/) (version 0.9.0 or higher)
- [Git](https://git-scm.com/) (for cloning the repository and managing plugins)
- A terminal with a [Nerd Font](https://www.nerdfonts.com/) (recommended for icons and UI elements)
- Optional: Language servers for your programming languages (e.g., via `npm`, `pip`, or other package managers)

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/quiet-ghost/nvim.git ~/.config/nvim
   ```

2. **Start Neovim**:
   ```bash
   nvim
   ```

3. **Install Plugins**:
   LazyVim will automatically install plugins on the first run. Wait for the plugin installation to complete (you'll see a notification in Neovim).

4. **Optional: Install Language Servers**:
   If you use LSP, install the necessary language servers for your programming languages. For example:
   - Python: `pip install pyright`
   - JavaScript/TypeScript: `npm install -g typescript-language-server`

## Structure

- `init.lua`: Entry point for the Neovim configuration.
- `lua/config/`: Core LazyVim configuration files (e.g., options, keymaps).
- `lua/plugins/`: Plugin specifications and custom configurations.
- `after/ftplugin/`: Filetype-specific settings.

## Customization

To customize this configuration:

1. Edit `lua/config/options.lua` for general Neovim settings.
2. Modify `lua/config/keymaps.lua` to add or change keybindings.
3. Add or remove plugins in `lua/plugins/`. Each plugin has its own file for clarity.
4. Refer to the [LazyVim documentation](https://www.lazyvim.org/) for advanced configuration options.

## Contributing

This is a personal configuration, but suggestions and improvements are welcome! Feel free to open an issue or submit a pull request.

## License

This configuration is licensed under the [MIT License](LICENSE).

## Acknowledgments

- [LazyVim](https://www.lazyvim.org/) for providing an excellent foundation.
- The Neovim community for their amazing plugins and resources.