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
                model = "claude-3.5-sonnet",
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
        cmd = "CodeCompanionChat",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require("codecompanion").setup({
                interactions = {
                    chat = {
                        adapter = "openrouter",
                    },
                    inline = {
                        adapter = "openrouter",
                    },
                    cmd = {
                        adapter = "openrouter",
                    },
                    background = {
                        adapter = "openrouter",
                    },
                },
                display = {
                    action_palette = {
                        provider = "telescope",
                    },
                },
                adapters = {
                    acp = {
                        acp = {
                            gemini_cli = function()
                                return require("codecompanion.adapters").extend("gemini_cli", {
                                    commands = {
                                        default = {
                                            "gemini",
                                            "--experimental-acp",
                                        },
                                    },
                                    defaults = {
                                        auth_method = "gemini-api-key",
                                        mcpServers = {},
                                        timeout = 20000, -- 20 seconds
                                    },
                                    env = {
                                        GEMINI_API_KEY = "GEMINI_API_KEY",
                                    },
                                })
                            end,
                        },
                    },
                    http = {
                        openai = function()
                            return require("codecompanion.adapters").extend("openai", {
                                schema = {
                                    model = {
                                        default = "gpt-5.1",
                                    },
                                },
                            })
                        end,
                        gemini = function()
                            return require("codecompanion.adapters").extend("gemini", {
                                env = {
                                    api_key = "GEMINI_API_KEY",
                                },
                                schema = {
                                    model = {
                                        default = "gemini-2.5-pro",
                                    },
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
                                    model = {
                                        default = "x-ai/grok-4.1-fast"
                                    },
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
                                    model = {
                                        default = "gpt-oss:20b"
                                    },
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
}
