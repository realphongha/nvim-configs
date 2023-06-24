" Index
"" => General
"" => UI 
"" => Apperance 
"" => Mapping
"" => Autocmd

" => General {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Number of lines of history
set history=500

" Auto read file changes
set autoread
au FocusGained,BufEnter * checktime

" Unicode
set encoding=utf-8

" No backup
set nobackup
set nowb
set noswapfile

" Use system clipboard
set clipboard^=unnamed,unnamedplus


" Tab and indent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai " Auto indent
set si " Smart indent
set wrap " Wrap lines

" Enable filetype plugins
filetype plugin on
filetype indent on

" Use magic for regex
set magic

" Show matching brackets when text indicator is over them
set showmatch

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" Split windows to right and below
set splitright
set splitbelow

" Detect OS
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" }}}

" => UI {{{ 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show line numbers
set number 

" Ruler
set textwidth=79
set colorcolumn=79

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Show current position
set ruler

" No annoying error sound
set noerrorbells
set novisualbell
set t_vb =
set tm=500

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ PATH:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" }}}

" => Apperance {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntax highlight
syntax enable

" Background
set background=dark

" Colorscheme
colorscheme catppuccin-macchiato

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac
" }}}

" => Mapping {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set Leader key to Space
let mapleader=" "

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor=getpos(".")
    let old_query=getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Quickly edit vimrc file in the left window pane
:nnoremap <leader>ev <c-w>l:e $MYVIMRC<cr>

" Quickly source vimrc file
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Quickly surround selected text in punctuation marks
:vnoremap <leader>" xa""<Esc>P
:vnoremap <leader>' xa''<Esc>P
:vnoremap <leader>( xa()<Esc>P
:vnoremap <leader>{ xa{}<Esc>P

" Quickly exit Terminal mode
:tnoremap <Esc> <C-\><C-n>

" Map terminal opening settings
if has("nvim")
    if g:os == "Darwin"
        command Terminal split term://zsh
        command TerminalTab tabe term://zsh
    elseif g:os == "Linux"
        command Terminal split term://bash
        command TerminalTab tabe term://bash
    endif
else
    command Terminal hori term
    command TerminalTab tab term
endif

" Quickly open terminal and resize terminal window
if has("nvim")
    :nnoremap <leader>t :Terminal<cr>:resize 10<cr>i
else
    :nnoremap <leader>t :Terminal<cr><c-w>N:resize 10<cr>i
endif

" Quickly removes hightlight
:noremap <leader><Esc> :noh<cr>

" Preserves current yanked after paste
:vnoremap <leader>p "_dp

" Quickly moves block up and down
:vnoremap J :m '>+1<CR>gv=gv
:vnoremap K :m '<-2<CR>gv=gv

" }}}

" => Autocmd {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup common

    autocmd!
    
    " Auto open netrw
    autocmd VimEnter * if argc() == 0 | NERDTree | endif

    " Cute cat welcomes you each time enter Vim
    autocmd VimEnter * echo "Hi >^.^<"

    " Auto save when losing focus
    autocmd FocusLost * nested silent! wall

    " Auto format JSON files
    autocmd BufWritePre *.json :execute '%!python -m json.tool' | w  

    " Auto delete trailing spaces
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

    " Folding vimscript by marker
    autocmd FileType vim setlocal foldmethod=marker

augroup END

" }}}
