return {
    --------------------------------------------------------------------------
    -- {{{ nvim-telescope/telescope.nvim
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        lazy = true,
        cmd = "Telescope",
        keys = {
            { "<leader>a", mode = "n" },
            { "<C-p>",     mode = "n" },
            { "<leader>g", mode = "n" },
            { "<leader>b", mode = "n" },
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')

            require("which-key").add({
                { "<C-p>",     builtin.git_files,  desc = "Find files by name (in this git repo)" },
                { "<leader>a", builtin.find_files, desc = "Find files by name" },
                { "<leader>b", builtin.buffers,    desc = "Find buffers" },
                { "<leader>g", builtin.live_grep,  desc = "Live grep" },
            })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-tree/nvim-tree.lua
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

            -- Navigate to nvim configs directory and reload current tree root
            function GoToNvimConfigs()
                vim.cmd([[:cd ]] .. vim.fn.stdpath("config"))
                ReloadNvimTreeRoot()
            end

            require("which-key").add(
                {
                    { "<leader>r",  ":lua ReloadNvimTreeRoot()<CR>", desc = "Reload nvim-tree root",        mode = { "n", "o", "v" }, remap = false },
                    { "<leader>t",  ":NvimTreeToggle<cr>",           desc = "Toggle nvim-tree",             mode = { "n", "o", "v" }, remap = false },
                    { "<leader>v",  group = ".vimrc" },
                    { "<leader>vc", ":lua GoToNvimConfigs()<CR>",    desc = "Go to nvim configs directory", remap = false },
                }
            )

            -- Removes the annoying undercurl for executable files
            vim.api.nvim_create_autocmd({ "ColorScheme" }, {
                callback = function()
                    vim.cmd([[
                        :hi link NvimTreeExecFile NvimTreeNormal
                    ]])
                end
            })
        end,
    },
    -- }}}

}
