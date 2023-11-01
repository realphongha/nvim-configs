"" Plugin configs

" => the silver searcher {{{
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" }}}

" => netrw {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disables netrw by default
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split=4
let g:netrw_altv=1

" Default to tree mode
let g:netrw_liststyle=3

" Keep the current directory and the browsing directory synced
let g:netrw_keepdir=0

" Window size
let g:netrw_winsize=20

" Hide banner
let g:netrw_banner=0

" Enable recursive copy
let g:netrw_localcopydircmd='cp -r'

" Sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" Highlight marked files
hi! link netrwMarkFile Search

" }}}

" => lightline {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Statusline contents
let g:lightline = {
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['gitbranch', 'readonly', 'relativepath', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

" }}}

" => vim-yankstack  {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map cycle yank history keybindings to <Leader> key
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" }}}

"" Language-wise plugins 

