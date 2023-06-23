# nvim-configs
Reusable configurations for Neovim and auto-install script.  
Tested on nvim 0.9.0, 0.9.1

# How to install  
First clone this repo  
`git clone https://github.com/realphongha/nvim-configs.git`  
`cd nvim-configs`  
get all submodules by  
`git submodule update --init --recursive`
then  
`python3 install.py` to install. See install.py for more options when
installing.  
You can now `rm -rf nvim-configs` to save disk space.  
For reinstalling, ~/.config/nvim and ~/.local/share/nvim or ~/AppData/Local/nvim
for Windows must be deleted first. You can also do that with --reinstall flag:  
`python3 install.py --reinstall`

# Install LSP servers:
Some LSP servers are already integrated in .lua configs but you need to install
them first.
## For pyright:
`npm i -g pyright`  
pyright configs are already on config.lua.
## For tsserver
`npm install -g typescript typescript-language-server`
## For rust-analyzer
[Install](https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary)
## For ccls
[Install](https://github.com/MaskRay/ccls/wiki)
## For clangd
[Install](https://clangd.llvm.org/installation.html)
# Add customized configs
Create vimrcs/my_configs.vim or luas/my_configs.lua and customize your own configs.
Then install it with the same commands above.

# Acknowledgements
This repo is directly inspired by [vimrc](https://github.com/amix/vimrc) and 
[Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/).  
## Plugins included:
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [lightline.vim](https://github.com/itchyny/lightline.vim)
* [nerdtree](https://github.com/preservim/nerdtree)
* [vim-gitbranch](https://github.com/itchyny/vim-gitbranch)
* [vim-yankstack](https://github.com/maxbrunsfeld/vim-yankstack)
* [vim-markdown](https://github.com/preservim/vim-markdown)
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
* [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
* [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
* [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
* [cmp-path](https://github.com/hrsh7th/cmp-path)
* [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
## Colorschemes included:
* [catppuccin](https://github.com/catppuccin/nvim)
* [tokyonight](https://github.com/folke/tokyonight.nvim)
* [gruvbox](https://github.com/morhetz/gruvbox)
* [monokai](https://github.com/sickill/vim-monokai)
* [peaksea](https://github.com/vim-scripts/peaksea)
* [solarized](https://github.com/altercation/vim-colors-solarized)
## Others
* [the_silver_searcher](https://github.com/ggreer/the_silver_searcher) is 
supported as 'grep' command (but you need to install it on your system first)
* [ccls LSP](https://github.com/MaskRay/ccls)
* [clangd LSP](https://clangd.llvm.org/)
* [pyright LSP](https://github.com/microsoft/pyright)
* [tsserver LSP](https://github.com/microsoft/TypeScript/wiki/Standalone-Server-(tsserver))
* [rust-analyzer LSP](https://github.com/rust-lang/rust-analyzer)
# PS
Some other useful plugins the fuzzy file finder [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) or a third-party plugin manager are not included in this project. I'm still using built-in Vim plugins instead :). Feel free to customize them as you like.
