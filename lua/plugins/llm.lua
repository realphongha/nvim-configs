return {
    --------------------------------------------------------------------------
    -- {{{ copilot.vim
    {
        "github/copilot.vim",
        lazy = true,
        cmd = "Copilot",
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
        lazy = true,
        keys = {
            { "<leader>cc", mode = { "n", "v" } },
        },
        cmd = "CopilotChat",
        dependencies = {
            { "github/copilot.vim" },                               -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" },         -- for curl, log and async functions
        },
        build = vim.g.os == "Windows_NT" and "" or "make tiktoken", -- Only on MacOS or Linux
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
        keys = {
            { "<leader>cc", mode = { "n", "v" } },
        },
        cmd = "CodeCompanion",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        adapter = "ollama_qwq",
                        -- adapter = "ollama_deepseek_r1",
                        -- adapter = "copilot",
                    },
                    inline = {
                        adapter = "ollama_qwq",
                        -- adapter = "ollama_deepseek_r1",
                        -- adapter = "copilot",
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
                    ollama_qwq = function()
                        return require("codecompanion.adapters").extend("ollama", {
                            env = {
                                url = "http://127.0.0.1:11434",
                            },
                            schema = {
                                model = {
                                    default = "qwq:32b"
                                },
                                temperature = {
                                    default = 0.0
                                }
                            }
                        })
                    end,
                }
            })
            require("which-key").add({
                { "<leader>cc", ":CodeCompanionChat<CR>", desc = "Open CodeCompanion Chat" },
            })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ minuet-ai.nvim
    {
        'milanglacier/minuet-ai.nvim',
        lazy = true,
        cmd = "Minuet",
        config = function()
            require('minuet').setup {
                provider = 'openai_fim_compatible',
                n_completions = 3, -- recommend for local model for resource saving
                -- I recommend beginning with a small context window size and incrementally
                -- expanding it, depending on your local computing power. A context window
                -- of 512, serves as an good starting point to estimate your computing
                -- power. Once you have a reliable estimate of your local computing power,
                -- you should adjust the context window to a larger value.
                context_window = 512,
                provider_options = {
                    openai_fim_compatible = {
                        api_key = 'TERM',
                        name = 'Ollama',
                        end_point = 'http://127.0.0.1:11434/v1/completions',
                        model = 'qwen2.5-coder:7b',
                        optional = {
                            max_tokens = 56,
                            top_p = 0.9,
                        },
                    },
                },
                virtualtext = {
                    auto_trigger_ft = { "*", },
                    keymap = {
                        -- accept whole completion
                        accept = '<C-c>',
                        -- accept one line
                        -- accept_line = '<A-a>',
                        -- accept n lines (prompts for number)
                        -- e.g. "A-z 2 CR" will accept 2 lines
                        -- accept_n_lines = '<A-z>',
                        -- Cycle to prev completion item, or manually invoke completion
                        prev = '<C-f>',
                        -- Cycle to next completion item, or manually invoke completion
                        next = '<C-g>',
                        -- dismiss = '<A-e>',
                    },
                },

            }
        end,
    },
    -- }}}
}
