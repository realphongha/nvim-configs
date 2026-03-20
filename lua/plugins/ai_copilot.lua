return {
    --------------------------------------------------------------------------
    -- {{{ CopilotC-Nvim/CopilotChat.nvim
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        keys = {
            { "<leader>cg", mode = { "n", "v" } },
        },
        cmd = "CopilotChat",
        dependencies = {
            { "github/copilot.vim" },                               -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" },         -- for curl, log and async functions
        },
        build = vim.g.os == "Windows_NT" and "" or "make tiktoken", -- Only on MacOS or Linux
        config = function()
            require("CopilotChat").setup({
                model = "gpt-5.4-mini",
            })
            require("which-key").add({
                { "<leader>cg", ":CopilotChat<CR>", desc = "Open Github Copilot Chat" },
            })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ olimorris/codecompanion.nvim
    {
        "olimorris/codecompanion.nvim",
        -- set lazy to true if we cannot connect to the url
        lazy = true,
        keys = {
            { "<leader>cc", mode = { "n", "v" } },
        },
        cmd = { "CodeCompanionChat", "CodeCompanion", "CodeCompanionCmd", "CodeCompanionActions" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require("codecompanion").setup({
                interactions = {
                    chat = {
                        adapter = { name = "openrouter", model = "gpt-5.4-mini"},
                        keymaps = {
                            close = {
                                modes = { n = "<C-x>", i = "<C-x>" },
                            },
                        },
                    },
                    inline = {
                        adapter = { name = "openrouter", model = "gpt-5.4-mini"},
                    },
                    cmd = {
                        adapter = { name = "openrouter", model = "gpt-5.4-nano"},
                    },
                    background = {
                        adapter = { name = "openrouter", model = "gpt-5.4-nano"},
                        chat = {
                            callbacks = {
                                ["on_ready"] = {
                                    actions = {
                                        "interactions.background.builtin.chat_make_title",
                                    },
                                    -- Enable "on_ready" callback which contains the title generation action
                                    enabled = true,
                                },
                            },
                            opts = {
                                -- Enable background interactions generally
                                enabled = true,
                            },
                        },
                    },
                },
                display = {
                    action_palette = {
                        provider = "telescope",
                    },
                },
                adapters = {
                    http = {
                        openai = function()
                            return require("codecompanion.adapters").extend("openai", {
                                env = {
                                    api_key = "OPENAI_API_KEY",
                                },
                                schema = {
                                    max_tokens = {
                                        default = 65536,
                                    }
                                }
                            })
                        end,
                        gemini = function()
                            return require("codecompanion.adapters").extend("gemini", {
                                env = {
                                    api_key = "GEMINI_API_KEY",
                                },
                                schema = {
                                    max_tokens = {
                                        default = 65536,
                                    }
                                }
                            })
                        end,
                        openrouter = function()
                            return require("codecompanion.adapters").extend("openai_compatible", {
                                env = {
                                    url = "https://openrouter.ai/api",
                                    api_key = "OPENROUTER_API_KEY",
                                    chat_url = "/v1/chat/completions",
                                },
                                handlers = {
                                    parse_message_meta = function(self, data)
                                        return data
                                    end,
                                },
                                schema = {
                                    max_tokens = {
                                        default = 65536,
                                    }
                                }
                            })
                        end,
                        ollama = function()
                            return require("codecompanion.adapters").extend("ollama", {
                                env = {
                                    url = "http://127.0.0.1:11434",
                                },
                                schema = {
                                    max_tokens = {
                                        default = 65536,
                                    }
                                }
                            })
                        end,
                        vllm = function()
                            return require("codecompanion.adapters").extend("ollama", {
                                env = {
                                    url = "http://127.0.0.1:8000/v1",
                                },
                                schema = {
                                    max_tokens = {
                                        default = 65536,
                                    }
                                }
                            })
                        end,
                    }
                }
            })
            require("which-key").add({
                { "<leader>cc", ":CodeCompanionChat<CR>", desc = "Open CodeCompanion Chat" },
            })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ coder/claudecode.nvim
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>a",  nil,                              desc = "Claude Code Agent" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeSend<cr>",
                mode = "v",
                desc = "Send to Claude",
            },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
        },
    },
    -- }}}
}
