# nvim-configs
My neovim configs and auto-install script.  
Tested with nvim 0.9.x on MacOS, Linux and Windows.

# How to install?
First clone this repo  
`git clone https://github.com/realphongha/nvim-configs.git`  
`cd nvim-configs`  
then  
`python3 install.py` to install (or `python3 install.py --reinstall` to reset all neovim data first)

# Plugin manager
[lazy.nvim](https://github.com/folke/lazy.nvim)
## Lazy load:
* `:LspStart` to load nvim-lspconfig (pls run it once after installing this config to initialize LSP servers)
* `:Git` to load vim-fugitive
* `:Codeium` to load codeium.vim (and `:Codeium Auth` to enter your token)

# Install LSP servers:
Some LSP servers are already integrated in configs but you need to install
them first.
## You can use [mason.nvim](https://github.com/williamboman/mason.nvim) (already installed) or manually install (below):
## For jedi
`pip install jedi-language-server`
## For pyright:
`npm i -g pyright`  
## For tsserver
`npm install -g typescript typescript-language-server`
## For rust-analyzer
[Install](https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary)
## For ccls
[Install](https://github.com/MaskRay/ccls/wiki)
## For clangd
[Install](https://clangd.llvm.org/installation.html)
## For cmake-language-server
[Install](https://github.com/regen100/cmake-language-server)
## For rust-analyzer
[Install](https://github.com/rust-lang/rust-analyzer)
## For lua-language-server
[Install](https://luals.github.io/#neovim-install) 
## To add other LSP supports:
* Install LSP servers (manually or using mason.nvim)
* Add LSP configs for neovim in `plugins/coding.lua`, mason-lspconfig->config section.
* Add lazy load condition to nvim-lspconfig->ft section in `plugins/codding.lua`

# Add your personal configs and plugins
Create `vimrcs/my_configs.lua` for your personal configs or 
`my_plugins/<plugin_name>.lua` for your personal plugins.
Then install it with the same commands above.

# Acknowledgements
This repo is directly inspired by [vimrc](https://github.com/amix/vimrc), 
[ThePrimeagen video](https://www.youtube.com/watch?v=w7i4amO_zaE) and 
[Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/).  
## Plugins included:
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [vim-sleuth](https://github.com/tpope/vim-sleuth)
* [lightline.vim](https://github.com/itchyny/lightline.vim)
* [undotree](https://github.com/mbbill/undotree.git)
* [vim-doge](https://github.com/kkoomen/vim-doge.git)
* [vim-fugitive](https://github.com/tpope/vim-fugitive.git)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
* [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
* [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
* [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
* [cmp-path](https://github.com/hrsh7th/cmp-path)
* [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [plenary.nvim](https://github.com/nvim-lua/plenary.nvim.git)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
* [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
* [nvim-web-icons](https://github.com/nvim-tree/nvim-web-devicons)
* [mason.nvim](https://github.com/williamboman/mason.nvim)
* [which-key.nvim](https://github.com/folke/which-key.nvim)
* [codeium.vim](https://github.com/Exafunction/codeium.vim)
## Colorschemes included:
* [rose-pine](https://github.com/rose-pine/neovim.git)
* [catppuccin](https://github.com/catppuccin/nvim)
* [tokyonight](https://github.com/folke/tokyonight.nvim)
* [gruvbox](https://github.com/morhetz/gruvbox)
* [monokai](https://github.com/sickill/vim-monokai)
* [peaksea](https://github.com/vim-scripts/peaksea)
* [solarized](https://github.com/altercation/vim-colors-solarized)
## Others
* [the_silver_searcher](https://github.com/ggreer/the_silver_searcher) is 
supported as 'grep' command (but you need to install it on your system first)
* [ripgrep](https://github.com/BurntSushi/ripgrep#installation) should be
installed first if you want to use telescope livegrep
* [Patched fonts](https://www.nerdfonts.com/) should be installed for nvim-tree

# Small notes
* Use `:lua SeeWaifu()` or `:lua SeeWaifu("colorscheme-name")` to make your background transparent and see your waifu
in the terminal :D
* Simple Neovim Qt configs is also supported (in `vimrcs/ginit.vim`). 
[Neovim Qt](https://github.com/equalsraf/neovim-qt) must be installed first. 
You can run `misc/add_nvimqt_to_context_menu_windows.reg` to add Neovim Qt to
context menu (only for Windows) (stolen from [here](https://github.com/neovim/neovim/issues/7222#issuecomment-927413185)) :D
* Check out [my minimal configs for tmux](https://gist.github.com/realphongha/abbc89ad908d94afa054049b64eb7917) if you want to use it with nvim
