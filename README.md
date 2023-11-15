# nvim-configs
My neovim configs and auto-install script.  
Tested with nvim 0.9.0, 0.9.1, 0.9.2, 0.9.3 on MacOS, Linux and Windows.

# How to install?
First clone this repo  
`git clone https://github.com/realphongha/nvim-configs.git`  
`cd nvim-configs`  
get all submodules by  
`git submodule update --init --recursive`
then  
`python3 install.py` to install. See install.py for more options when
installing.  
For reinstalling, ~/.config/nvim and ~/.local/share/nvim or ~/AppData/Local/nvim
for Windows must be deleted first. You can also do that with --reinstall flag:  
`python3 install.py --reinstall`  
Extended plugins is not installed by default, you can clone repos into
extended_plugins and install them with --extended-plugins flag: `python3
install.py --extended-plugins`  

# How to add new own plugins?
You can add new plugins as a submodule to install by:  
`git submodule add <plugin_git_repo_url> my_plugins/<plugin_name>` and
specify the branch name for the submodule in `.gitmodules` (so it can be
updated).  
Plugins can also be removed by `git rm <path/to/submodule>`.

# How to update?
`git submodule update --remote`

# Install LSP servers:
Some LSP servers are already integrated in .lua configs but you need to install
them first.
## You can use [mason.nvim](https://github.com/williamboman/mason.nvim) (already installed) or manually install (below):
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
# Add customized configs
Create vimrcs/my_configs.vim or luas/my_configs.lua and customize your own configs.
Then install it with the same commands above.

# Acknowledgements
This repo is directly inspired by [vimrc](https://github.com/amix/vimrc), 
[ThePrimeagen video](https://www.youtube.com/watch?v=w7i4amO_zaE) and 
[Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/).  
## Plugins included:
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [lightline.vim](https://github.com/itchyny/lightline.vim)
* [vim-fugitive](https://github.com/tpope/vim-fugitive.git)
* [vim-yankstack](https://github.com/maxbrunsfeld/vim-yankstack)
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
* You can run `misc/add_nvimqt_to_context_menu_windows.reg` to add Neovim Qt to
context menu (only for Windows) (stolen from [here](https://github.com/neovim/neovim/issues/7222#issuecomment-927413185)) :D
* Check out [my minimal configs for tmux](https://gist.github.com/realphongha/abbc89ad908d94afa054049b64eb7917) if you want to use it with nvim

# PS
A third-party package manager is not included in this project. I'm still using built-in Vim package manager instead :). Feel free to customize them as you like.
