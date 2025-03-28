return {
    --------------------------------------------------------------------------
    -- {{{ copilot.vim
    {
        "github/copilot.vim",
        lazy = true,
        cmd = "Copilot",
        keys = {
            { "<C-c>", mode = { "i" } },
            { "<C-f>", mode = { "i" } },
            { "<C-g>", mode = { "i" } }
        },
        config = function()
            vim.keymap.set('i', '<C-c>',
                'copilot#Accept("\\<CR>")',
                { expr = true, silent = true, noremap = true, replace_keycodes = false })
            vim.keymap.set('i', '<C-f>',
                'copilot#Previous()',
                { expr = true, silent = true, noremap = true })
            vim.keymap.set('i', '<C-g>',
                'copilot#Next()',
                { expr = true, silent = true, noremap = true })
            vim.g.copilot_no_tab_map = true
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ CopilotChat.nvim
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = false,
        keys = {
            { "<leader>cc", mode = { "n", "v" } },
        },
        cmd = "CopilotChat",
        dependencies = {
            { "github/copilot.vim" },                 -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                      -- Only on MacOS or Linux
        -- opts = {
        --     model = "claude-3.5-sonnet",
        -- },
        config = function()
            require("CopilotChat").setup({
                model = "claude-3.5-sonnet",
            })
            require("which-key").add({
                { "<leader>cc", ":CopilotChat<CR>", desc = "Open Copilot Chat" },
            })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ codeium.vim
    {
        'Exafunction/codeium.vim',
        cmd = "Codeium",
        keys = {
            { "<C-c>", mode = { "i" } },
            { "<C-f>", mode = { "i" } },
            { "<C-g>", mode = { "i" } }
        },
        config = function()
            vim.g.codeium_disable_bindings = 1
            vim.keymap.set('i', '<C-c>',
                function() return vim.fn['codeium#Accept']() end,
                { expr = true, silent = true, noremap = true })
            vim.keymap.set('i', '<C-f>',
                function() return vim.fn['codeium#CycleCompletions'](1) end,
                { expr = true, silent = true, noremap = true })
            vim.keymap.set('i', '<C-g>',
                function() return vim.fn['codeium#CycleCompletions'](-1) end,
                { expr = true, silent = true, noremap = true })
            -- vim.keymap.set('i', '<C-x>',
            --     function() return vim.fn['codeium#Clear']() end,
            --     { expr = true, silent = true, noremap = true })
            -- vim.keymap.set('i', '<C-]>',
            --     function() return vim.fn['codeium#Complete']() end,
            --     { expr = true, silent = true, noremap = true })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ codecompanion.nvim
    {
        "olimorris/codecompanion.nvim",
        -- set lazy to true if we cannot connect to the url
        lazy = true,
        cmd = "CodeCompanion",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        -- adapter = "ollama_deepseek_r1",
                        adapter = "copilot",
                    },
                    inline = {
                        -- adapter = "ollama_deepseek_r1",
                        adapter = "copilot",
                    },
                },
                adapters = {
                    ollama_deepseek_r1 = function()
                        return require("codecompanion.adapters").extend("ollama", {
                            env = {
                                url = "http://127.0.0.1:11434",
                            },
                            schema = {
                                model = {
                                    default = "deepseek-r1:14b"
                                },
                                temperature = {
                                    default = 0.0
                                }
                            }
                        })
                    end,
                }
            })
        end
    },
    -- }}}
}
