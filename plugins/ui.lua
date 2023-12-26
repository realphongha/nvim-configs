return {
    --------------------------------------------------------------------------
    -- {{{ lightline.vim
    {
        "itchyny/lightline.vim",
        lazy = false,
        config = function ()
            vim.cmd([[
            " Statusline contents
            " let colorscheme = 'catppuccin'
            let g:lightline = {
            \ 'active': {
            \   'left': [ ['mode', 'paste'],
            \             ['gitbranch', 'readonly', 'relativepath', 'modified'] ],
            \   'right': [ [ 'lineinfo' ], ['percent'] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ 'separator': { 'left': ' ', 'right': ' ' },
            \ 'subseparator': { 'left': ' ', 'right': ' ' },
            \ 'colorscheme': 'default',
            \ }

            function! s:lightline_update()
              if !exists('g:loaded_lightline')
                return
              endif
              try
                if stridx(g:colors_name, "catppuccin") >= 0
                  let g:lightline.colorscheme = "catppuccin"
                else
                  let g:lightline.colorscheme = "default" 
                endif
                call lightline#init()
                call lightline#colorscheme()
                call lightline#update()
              catch
              endtry
            endfunction

            augroup LightlineColorscheme
              autocmd!
              autocmd ColorScheme * call s:lightline_update()
            augroup END
            ]])
        end
    },
    -- }}}
}
