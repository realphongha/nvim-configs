" Index
"" => General
"" => UI 
"" => Apperance 
"" => Mapping
"" => Autocmd

" => General {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" }}}

" => UI {{{ 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" }}}

" => Mapping {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
if g:os == "Windows"
    :nnoremap <leader>T :split<cr>:resize 10<cr>:term<cr>i
else
    if has("nvim")
        :nnoremap <leader>T :Terminal<cr>:resize 10<cr>i
    else
        :nnoremap <leader>T :Terminal<cr><c-w>N:resize 10<cr>i
    endif
endif

" }}}

" => Autocmd {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" }}}
