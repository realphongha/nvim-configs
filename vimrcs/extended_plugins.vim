"" Extended plugin configs

" => nerdtree {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto open project tree
autocmd VimEnter * if argc() == 0 | NERDTree | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' && &buftype != 'quickfix' | silent! NERDTreeMirror | endif

" tree on left side of the screen
let g:NERDTreeWinPos = "left"

" show hidden files
let NERDTreeShowHidden=1

" Ignore files
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

" Window size
let g:NERDTreeWinSize=35


" }}}
