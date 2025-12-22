return {
    --------------------------------------------------------------------------
    -- {{{ windwp/nvim-autopairs
    {
        'windwp/nvim-autopairs',
        lazy = true,
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ mfussenegger/nvim-dap
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        keys = {
            { "<leader>zb", mode = { "n" } },
        },
        config = function()
            local dap = require('dap')
            local widgets = require('dap.ui.widgets')
            require("which-key").add({
                { "<leader>z",  group = "Nvim-DAP" },
                { "<leader>zb", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
                { "<leader>zc", dap.continue,          desc = "Continue" },
                { "<leader>zo", dap.step_over,         desc = "Step over" },
                { "<leader>zi", dap.step_into,         desc = "Step into" },
                { "<leader>zr", dap.repl.open,         desc = "Open REPL" },
                {
                    "<leader>zs",
                    function()
                        widgets.centered_float(widgets.scopes)
                    end,
                    desc = "Open current scopes in a floating window"
                },
                {
                    "<leader>zf",
                    function()
                        widgets.centered_float(widgets.frames)
                    end,
                    desc = "Open current frames in a floating window"
                },
                {
                    "<leader>zv",
                    function()
                        widgets.hover()
                    end,
                    desc = "View the value of the expression in a floating window"
                },
            })

            -- C++
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }
            dap.adapters.cpp = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    pid = function()
                        local name = vim.fn.input('Executable name (filter): ')
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    cwd = '${workspaceFolder}'
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'gdb',
                    request = 'attach',
                    target = 'localhost:1234',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}'
                },

            }

            -- Python
            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                    ---@diagnostic disable-next-line: undefined-field
                    local port = (config.connect or config).port
                    ---@diagnostic disable-next-line: undefined-field
                    local host = (config.connect or config).host or '127.0.0.1'
                    cb({
                        type = 'server',
                        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                        host = host,
                        options = {
                            source_filetype = 'python',
                        },
                    })
                else
                    cb({
                        type = 'executable',
                        command = 'python',
                        args = { '-m', 'debugpy.adapter' },
                        options = {
                            source_filetype = 'python',
                        },
                    })
                end
            end
            dap.configurations.python = {
                {
                    -- The first three options are required by nvim-dap
                    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
                    request = 'launch',
                    name = "Launch file",

                    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                    program = "${file}", -- This configuration will launch the current file if used.
                    pythonPath = function()
                        return "python"
                    end,
                },
            }
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ mason-org/mason.nvim
    {
        "mason-org/mason.nvim",
        lazy = true,
        cmd = "Mason",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = {},
    },
    -- }}}

    --------------------------------------------------------------------------
    --  {{{ mason-org/mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = true,
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig"
        },
        config = function()
            local ensure_installed = { "lua_ls", "marksman" }
            if vim.fn.executable("jedi-language-server") == 0 then
                table.insert(ensure_installed, "jedi_language_server")
            end
            if vim.fn.executable("typescript-language-server") == 0 and vim.fn.executable("npm") == 1 then
                table.insert(ensure_installed, "ts_ls")
            end
            -- if vim.fn.executable("debugpy") == 0 then
            --     table.insert(ensure_installed, "debugpy")
            -- end
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
            }
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- pyright
            -- local python_path = vim.fn.trim(vim.fn.system("which python"))
            -- vim.lsp.config('pyright', {
            --     settings = {
            --         python = {
            --             pythonPath = python_path,
            --         }
            --     },
            --     capabilities = capabilities
            -- })

            -- jedi
            vim.lsp.config('jedi_language_server', {
                cmd = { "jedi-language-server" },
                filetypes = { "python" },
                single_file_support = true,
            })

            -- ts_ls
            vim.lsp.config('ts_ls', {
                capabilities = capabilities
            })

            -- rust_analyzer
            vim.lsp.config('rust_analyzer', {
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ['rust-analyzer'] = {
                        diagnostic = {
                            enable = false,
                        }
                    },
                },
                capabilities = capabilities
            })

            -- ccls
            vim.lsp.config('ccls', {
                capabilities = capabilities
            })

            -- clangd.
            vim.lsp.config('clangd', {
                capabilities = capabilities,
                support_single_file = true,
            })

            --cmake
            vim.lsp.config('cmake', {})

            --lua for nvim
            vim.lsp.config('lua_ls', {
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                            path ~= vim.fn.stdpath('config')
                            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                        then
                            return
                        end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most
                            -- likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Tell the language server how to find Lua modules same way as Neovim
                            -- (see `:h lua-module-load`)
                            path = {
                                'lua/?.lua',
                                'lua/?/init.lua',
                            },
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths
                                -- here.
                                -- '${3rd}/luv/library'
                                -- '${3rd}/busted/library'
                            }
                            -- Or pull in all of 'runtimepath'.
                            -- NOTE: this is a lot slower and will cause issues when working on
                            -- your own configuration.
                            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                            -- library = {
                            --   vim.api.nvim_get_runtime_file('', true),
                            -- }
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            })

            -- marksman
            vim.lsp.config('marksman', {})
        end
    },
    --  }}}

    --------------------------------------------------------------------------
    -- {{{ neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        cmd = "LspStart",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        ft = "python,markdown,lua,c,cpp,cuda,rust,javascript,typesript,cmake",
        config = function()
            require("which-key").add({
                { "<leader>e", vim.diagnostic.open_float, desc = "Open diagnostic float window" },
                { "<leader>q", vim.diagnostic.setloclist, desc = "Add buffer diagnostics to the location list" },
                { "[d",        vim.diagnostic.goto_next,  desc = "Go to next diagnostic" },
                { "]d",        vim.diagnostic.goto_prev,  desc = "Go to previous diagnostic" },
            })

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    require("which-key").add({
                        { "<C-k>",     vim.lsp.buf.signature_help,  buffer = ev.buf, desc = "Display hover signature" },
                        { "<Leader>D", vim.lsp.buf.type_definition, buffer = ev.buf, desc = "Type definition" },
                        {
                            "<Leader>f",
                            function()
                                vim.lsp.buf.format { async = true }
                            end,
                            buffer = ev.buf,
                            desc = "Format code"
                        },
                        { "<Leader>rn", vim.lsp.buf.rename,               buffer = ev.buf, desc = "Rename all references to the symbol" },
                        { "<Leader>w",  group = "[LSP] Workspace" },
                        { "<Leader>wa", vim.lsp.buf.add_workspace_folder, buffer = ev.buf, desc = "Add workspace folder" },
                        {
                            "<Leader>wl",
                            function()
                                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                            end,
                            buffer = ev.buf,
                            desc = "List workspace folders"
                        },
                        { "<Leader>wr", vim.lsp.buf.remove_workspace_folder, buffer = ev.buf, desc = "Remove workspace folder" },
                        { "K",          vim.lsp.buf.hover,                   buffer = ev.buf, desc = "Display hover information" },
                        { "gD",         vim.lsp.buf.declaration,             buffer = ev.buf, desc = "Go to declaration" },
                        { "gd",         vim.lsp.buf.definition,              buffer = ev.buf, desc = "Go to definition" },
                        { "gi",         vim.lsp.buf.implementation,          buffer = ev.buf, desc = "Go to implementation" },
                        { "gr",         vim.lsp.buf.references,              buffer = ev.buf, desc = "Go to references" },
                        { "<Leader>ca", vim.lsp.buf.code_action,             buffer = ev.buf, desc = "Code action",              mode = { "n", "v" } },
                    })
                end,
            })
        end
    },

    -- }}}

    --------------------------------------------------------------------------
    -- {{{ hrsh7th/nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            -- "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            'windwp/nvim-autopairs',
        },
        config = function()
            -- Set up nvim-cmp.
            local cmp = require 'cmp'

            cmp.setup({
                enabled = function()
                    if vim.g.enable_nvim_cmp == nil then
                        vim.g.enable_nvim_cmp = true
                    end
                    return vim.g.enable_nvim_cmp
                end,
                -- to remove LSP priority to select completion
                preselect = cmp.PreselectMode.None,
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', priority = 1000 },
                    { name = 'vsnip',    priority = 900 },
                    { name = 'buffer',   priority = 800 },
                    { name = 'path',     priority = 700 },
                })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            cmp.setup({
                mapping = {
                    -- If nothing is selected, <CR> will make a new line
                    ["<CR>"] = cmp.mapping({
                        i = function(fallback)
                            if cmp.visible() and cmp.get_active_entry() then
                                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                            else
                                fallback()
                            end
                        end,
                    }),
                    -- Tab to go to next suggestion
                    ["<Tab>"] = cmp.mapping({
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                fallback()
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                fallback()
                            end
                        end,
                        s = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                fallback()
                            end
                        end,
                    }),
                    -- S-Tab to go to last suggestion
                    ["<S-Tab>"] = cmp.mapping({
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                fallback()
                            end
                        end,
                        i = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                fallback()
                            end
                        end,
                        s = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                fallback()
                            end
                        end,
                    }),
                }
            })
            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvimtools/none-ls.vim
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        ft = "python,lua,c,cpp,rust,javascript,typesript,cmake",
        -- doesn't work, don't know why:
        -- keys = {
        --     { "<leader>f", mode = "n" }
        -- },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- spell
                    -- null_ls.builtins.completion.spell,

                    -- lua
                    null_ls.builtins.formatting.stylua,

                    -- python
                    null_ls.builtins.formatting.black.with({
                        command = { "black" },
                    }),
                    -- require("none-ls.diagnostics.flake8"),

                    -- c++
                    null_ls.builtins.formatting.clang_format,
                },
            });
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ kkoomen/vim-doge
    {
        "kkoomen/vim-doge",
        lazy = false,
        keys = {
            { "<leader>d", mode = "n" }
        },
        build = ":call doge#install()",
        config = function()
            -- Mappings
            require("which-key").add(
                {
                    { "<S-TAB>",   "<Plug>(doge-comment-jump-backward)", desc = "[vim-doge] Jump backward", mode = { "i", "n", "s" } },
                    { "<TAB>",     "<Plug>(doge-comment-jump-forward)",  desc = "[vim-doge] Jump forward",  mode = { "i", "n", "s" } },
                    { "<leader>d", "<Plug>(doge-generate)",              desc = "Generate docstring" },
                }
            )

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
    -- {{{ nvim-treesitter/nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "cmake", "markdown" },
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                -- ignore_install = { "javascript" },
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    -- list of language that will be disabled
                    -- disable = { "c", "rust" },
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    },

    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = 'V', -- linewise
                        },
                        -- include_surrounding_whitespace = true,
                    },
                },
            }
        end
    }

    -- }}}
}
