return {
    --------------------------------------------------------------------------
    -- {{{ telescope.nvim
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        lazy = true,
        keys = {
            {"<leader>a", mode = "n"},
            {"<C-p>", mode = "n"},
            {"<leader>g", mode = "n"},
            {"<leader>b", mode = "n"},
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>a', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>b', builtin.buffers, {})
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ plenary.nvim
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-tree.lua 
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    width = 35,
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                            modified = true
                        },
                    },
                },
                git = {
                    ignore = false
                },
                filters = {
                    dotfiles = false,
                },
            })

            -- open nvim tree
            function OpenNvimTree(data)
                -- if there're no args, set to current directory
                if data.file == '' or data.file == nil then
                    data.file = '.'
                end

                -- buffer is a directory
                local directory = vim.fn.isdirectory(data.file) == 1

                if not directory then
                    return
                end

                -- create a new, empty buffer
                vim.cmd.enew()

                -- wipe the directory buffer
                vim.cmd.bw(data.buf)

                -- change to the directory
                vim.cmd.cd(data.file)

                -- open the tree
                require("nvim-tree.api").tree.open()
            end

            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                callback = OpenNvimTree
            })

            -- Reload current tree root (navigated by :cd <path>)
            function ReloadNvimTreeRoot()
                require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
            end

            vim.api.nvim_set_keymap("", "<leader>r", ":lua ReloadNvimTreeRoot()<CR>",
                {noremap = true, silent = true}
            )

            -- Quickly toggle NvimTree
            vim.api.nvim_set_keymap("", "<leader>t", ":NvimTreeToggle<cr>",
                {noremap = true, silent = true}
            )

            -- Removes the annoying undercurl for executable files
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
                callback = function ()
                    vim.cmd([[
                        :hi link NvimTreeExecFile NvimTreeNormal
                    ]])
                end
            })
        end,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-web-devicons 
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            -- your personnal icons can go here (to override)
            -- you can specify color or cterm_color instead of specifying both of them
            -- DevIcon will be appended to `name`
            override = {
                zsh = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Zsh"
                }
            };
            -- globally enable different highlight colors per icon (default to true)
            -- if set to false all icons will have the default icon's color
            color_icons = true;
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true;
            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true;
            -- same as `override` but specifically for overrides by filename
            -- takes effect when `strict` is true
            override_by_filename = {
                [".gitignore"] = {
                    icon = "",
                    color = "#f1502f",
                    name = "Gitignore"
                }
            };
            -- same as `override` but specifically for overrides by extension
            -- takes effect when `strict` is true
            override_by_extension = {
                ["log"] = {
                    icon = "",
                    color = "#81e043",
                    name = "Log"
                }
            };
        }
    },
    -- }}}
}
