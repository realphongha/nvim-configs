return {
    --------------------------------------------------------------------------
    -- {{{ github/copilot.vim
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
    -- {{{ Exafunction/windsurf.vim
    {
        'Exafunction/windsurf.vim',
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
    -- {{{ monkoose/neocodeium
    {
        "monkoose/neocodeium",
        cmd = "Neocodeium",
        config = function()
            local neocodeium = require("neocodeium")
            neocodeium.setup()
            vim.keymap.set("i", "<C-c>", neocodeium.accept)
            vim.keymap.set("i", "<C-f>", neocodeium.cycle)
            vim.keymap.set("i", "<C-j>", neocodeium.accept_word)
            vim.keymap.set("i", "<C-l>", neocodeium.accept_line)
        end,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ milanglacier/minuet-ai.nvim
    {
        'milanglacier/minuet-ai.nvim',
        lazy = true,
        cmd = "Minuet",
        config = function()
            function add_filename_comment()
                if vim.bo.ft == nil or vim.bo.ft == '' then
                    return ''
                end

                local filename_string = 'filename: ' .. vim.fn.expand '%'
                local commentstring = vim.bo.commentstring

                if commentstring == nil or commentstring == '' then
                    return '# ' .. filename_string
                end

                -- Directly replace %s with the comment
                if commentstring:find '%%s' then
                    filename_string = commentstring:gsub('%%s', filename_string)
                    return filename_string
                end

                -- Fallback to prepending comment if no %s found
                return commentstring .. ' ' .. filename_string
            end

            require('minuet').setup {
                provider = 'codestral',
                throttle = 1500, -- Increase to reduce costs and avoid rate limits
                debounce = 600,  -- Increase to reduce costs and avoid rate limits
                n_completions = 1,
                context_window = 16384,
                -- after_cursor_filter_length = 20,
                provider_options = {
                    gemini = {
                        model = "gemini-2.5-flash-lite",
                        stream = true,
                        api_key = "GEMINI_API_KEY",
                        optional = {
                            generationConfig = {
                                maxOutputTokens = 64,
                                thinkingConfig = {
                                    thinkingBudget = 0,
                                }
                            },
                        },
                    },
                    openai = {
                        model = 'gpt-4.1-nano',
                        stream = true,
                        api_key = 'OPENAI_API_KEY',
                        optional = {
                            max_completion_tokens = 64,
                            reasoning_effort = "minimal",
                        },
                    },
                    codestral = {
                        model = 'codestral-latest',
                        end_point = 'https://api.mistral.ai/v1/fim/completions',
                        api_key = 'CODESTRAL_API_KEY',
                        stream = true,
                        template = {
                            prompt = function(context_before_cursor, _, _)
                                local utils = require 'minuet.utils'
                                local language = utils.add_language_comment()
                                -- local tab = utils.add_tab_comment()
                                local filename = add_filename_comment()
                                context_before_cursor = filename .. '\n'
                                    .. language .. '\n' .. context_before_cursor
                                return context_before_cursor
                            end,
                            suffix = function(_, context_after_cursor, _)
                                return context_after_cursor
                            end,
                        },
                        optional = {
                            max_tokens = 128,
                            stop = { '\n\n' },
                        },
                    },
                    openai_compatible = {
                        api_key = 'OPENROUTER_API_KEY',
                        end_point = 'https://openrouter.ai/api/v1/chat/completions',
                        model = 'openai/gpt-4.1-nano',
                        name = 'Openrouter',
                        optional = {
                            max_tokens = 64,
                        },
                    },
                    openai_fim_compatible = {
                        api_key = 'TERM',
                        name = 'Ollama',
                        end_point = 'http://127.0.0.1:11434/v1/completions',
                        model = 'qwen2.5-coder:7b',
                        optional = {
                            max_tokens = 64,
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

    --------------------------------------------------------------------------
    -- {{{ supermaven-inc/supermaven-nvim
    {
        "supermaven-inc/supermaven-nvim",
        lazy = true,
        cmd = "SupermavenStart",
        config = function()
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<C-c>",
                    accept_word = "<C-j>",
                },
            })
        end,
    },
    -- }}}
}
