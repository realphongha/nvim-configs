# nvim-configs
My neovim configs.  
Support nvim>=0.11 on MacOS, Linux and Windows.

# How to install?
Install [Neovim](https://github.com/neovim/neovim/releases/tag/stable) first.  
Then simply clone this repo directly into your Neovim configs directory:

## For Linux/Mac OS
```bash
# removes all your previous nvim configs first!
rm -rf ~/.config/nvim
# removes all your previous nvim data
# rm -rf ~/.local/share/nvim
git clone https://github.com/realphongha/nvim-configs.git ~/.config/nvim

```
## For Windows (on Powershell)
```powershell
# removes all your previous nvim configs first!
Remove-Item -Path "~/AppData/Local/nvim" -Recurse -Force
# removes all your previous nvim data 
# Remove-Item -Path "~/AppData/Local/nvim-data" -Recurse -Force
cd ~/AppData/Local/
git clone https://github.com/realphongha/nvim-configs.git nvim
```
Done!

## Optional requirements:
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation) should be
installed first if you want to use Telescope livegrep
* We need a [patched font](https://www.nerdfonts.com/) for better looking UI!
* Install [ImageMagick](https://imagemagick.org/script/download.php) for image preview 
with snacks.nvim
* [the_silver_searcher](https://github.com/ggreer/the_silver_searcher) is 
needed for 'grep' command support (Telescope livegrep is enough for me tho)
* For nvim-dap C/C++ support, you need gdb >= 14.1 built with python support, 
it can be check by `gdb -i dap`. You also need to build in debug mode.

# Plugin manager
We use [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

## Plugins included:
See `lua/plugins/*.lua`

## Colorschemes included:
* See `lua/plugins/colorscheme.lua`

## LSP support:
Some LSP servers are already integrated in configs but you need to install
them first, you can use [mason.nvim](https://github.com/williamboman/mason.nvim)
(already installed) or manually install them:
* jedi: `pip install jedi-language-server`
* pyright: `npm i -g pyright`  
* tsserver: `npm install -g typescript typescript-language-server`
* rust-analyzer: [Install](https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary)
* ccls: [Install](https://github.com/MaskRay/ccls/wiki)
* clangd: [Install](https://clangd.llvm.org/installation.html)
* cmake-language-server: [Install](https://github.com/regen100/cmake-language-server)
* rust-analyzer: [Install](https://github.com/rust-lang/rust-analyzer)
* lua-language-server: [Install](https://luals.github.io/#neovim-install) 

### To add other LSP supports:
* Add LSP configs for neovim in `lua/plugins/coding.lua`, mason-lspconfig->config section.
* Install LSP servers (manually or using mason.nvim)
* Add lazy load condition to nvim-lspconfig->ft section in `lua/plugins/coding.lua`

# To add your personal configs and plugins
Create `lua/my_configs.lua` for your personal configs or 
`lua/my_plugins.lua` for your personal plugins (in `lazy.nvim` format, already in .gitignore).

# Misc
* Check out [my configs for tmux](https://github.com/realphongha/dotfiles/blob/master/.tmux.conf).
It works seemlessly with nvim (vi mode, image support and all)
* Use `:lua SeeWaifu()` or `:lua SeeWaifu("colorscheme-name")` to make your background transparent and see your waifu
in the terminal :D
* A simple configs for Neovim GUI (i.e., `ginit.vim`) is also supported.
Should work with Neovide, VimR and NeovimQt
* For NeovimQt, you can run `misc/add_nvimqt_to_context_menu_windows.reg` to add NeovimQt to
context menu (only for Windows) (stolen from [here](https://github.com/neovim/neovim/issues/7222#issuecomment-927413185)) :D

# Acknowledgements
This repo is directly inspired by [LazyVim](https://github.com/LazyVim/LazyVim), 
[vimrc](https://github.com/amix/vimrc), and
[ThePrimeagen video](https://www.youtube.com/watch?v=w7i4amO_zaE).
