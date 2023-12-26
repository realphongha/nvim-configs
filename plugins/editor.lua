return {
    --------------------------------------------------------------------------
    -- {{{ vim-yankstack
    {
        "maxbrunsfeld/vim-yankstack",
        lazy = false,
        config = function ()
            -- Map cycle yank history keybindings to <Leader> key
            vim.api.nvim_set_keymap("n",
                "<leader>p", "<Plug>yankstack_substitute_older_paste",
                {noremap = true}
            )
            vim.api.nvim_set_keymap("n",
                "<leader>P", "<Plug>yankstack_substitute_newer_paste",
                {noremap = true}
            )
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ undotree 
    {
        "mbbill/undotree",
        lazy = true,
        keys = {
            {"u", mode = "n"}
        },
        config = function ()
            vim.api.nvim_set_keymap("n",
                "<leader>u", ":UndotreeToggle<CR>",
                {noremap = true}
            )
        end
    },

    -- }}}

    --------------------------------------------------------------------------
    -- {{{ vim-doge
    {
        "kkoomen/vim-doge",
        lazy = false,
        keys = {
            {"<Leader>d", mode = "n"}
        },
        build = ":call doge#install()",
        config = function ()
            -- Mappings
            vim.cmd([[
            nmap <silent> <Leader>d <Plug>(doge-generate)
            nmap <silent> <TAB> <Plug>(doge-comment-jump-forward)
            nmap <silent> <S-TAB> <Plug>(doge-comment-jump-backward)
            imap <silent> <TAB> <Plug>(doge-comment-jump-forward)
            imap <silent> <S-TAB> <Plug>(doge-comment-jump-backward)
            smap <silent> <TAB> <Plug>(doge-comment-jump-forward)
            smap <silent> <S-TAB> <Plug>(doge-comment-jump-backward)
            ]])
            -- Docstring standards
            vim.cmd([[
            let g:doge_doc_standard_python = 'google'
            let g:doge_doc_standard_c = 'doxygen_javadoc'
            let g:doge_doc_standard_cpp = 'doxygen_javadoc'
            ]])
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ commentary
    {
        "tpope/vim-commentary",
        lazy = true,
        keys = {
            {"gcc", mode = "n"},
            {"gc", mode = "v"},
        },
    },
    -- }}}
}
