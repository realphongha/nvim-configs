return {
    --------------------------------------------------------------------------
    -- {{{ nvim-autopairs
    {
        'windwp/nvim-autopairs',
        lazy = true,
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-dap
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
                { "<leader>z", group = "Nvim-DAP" },
                { "<leader>zb", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
                { "<leader>zc", dap.continue, desc = "Continue" },
                { "<leader>zo", dap.step_over, desc = "Step over" },
                { "<leader>zi", dap.step_into, desc = "Step into" },
                { "<leader>zr", dap.repl.open, desc = "Open REPL" },
                { "<leader>zs", function ()
                    widgets.centered_float(widgets.scopes)
                end, desc = "Open current scopes in a floating window" },
                { "<leader>zf", function ()
                    widgets.centered_float(widgets.frames)
                end, desc = "Open current frames in a floating window" },
                { "<leader>zv", function ()
                    widgets.hover()
                end, desc = "View the value of the expression in a floating window" },
            })

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
                type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch';
                name = "Launch file";

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}"; -- This configuration will launch the current file if used.
                pythonPath = function()
                    return "python"
                end;
              },
            }
            end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ mason.nvim
    {
        "williamboman/mason.nvim",
        lazy = true,
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    --  {{{ mason-lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig"
        },
        config = function()
            local ensure_installed = { "lua_ls", "marksman" }
            if vim.fn.executable("jedi-language-server") == 0 then
                table.insert(ensure_installed, "jedi_language_server")
            end
            if vim.fn.executable("typescript-language-server") == 0 then
                table.insert(ensure_installed, "ts_ls")
            end
            -- if vim.fn.executable("debugpy") == 0 then
            --     table.insert(ensure_installed, "debugpy")
            -- end
            require("mason-lspconfig").setup {
                ensure_installed = ensure_installed,
            }
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- pyright
            -- local python_path = vim.fn.trim(vim.fn.system("which python"))
            -- lspconfig.pyright.setup {
            --     settings = {
            --         python = {
            --             pythonPath = python_path,
            --         }
            --     },
            --     capabilities = capabilities
            -- }
            lspconfig.jedi_language_server.setup {
                cmd = { "jedi-language-server" },
                filetypes = { "python" },
                single_file_support = true,
            }

            -- ts_ls
            lspconfig.ts_ls.setup {
                capabilities = capabilities
            }

            -- rust_analyzer
            lspconfig.rust_analyzer.setup {
                -- Server-specific settings. See `:help lspconfig-setup`
                settings = {
                    ['rust-analyzer'] = {
                        diagnostic = {
                            enable = false,
                        }
                    },
                },
                capabilities = capabilities
            }

            -- ccls
            -- lspconfig.ccls.setup {
            --     capabilities = capabilities
            -- }

            -- clangd.
            lspconfig.clangd.setup {
                capabilities = capabilities,
                support_single_file = true,
            }

            --cmake
            lspconfig.cmake.setup {}

            --lua for nvim
            lspconfig.lua_ls.setup {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME
                                -- Depending on the usage, you might want to add additional paths here.
                                -- "${3rd}/luv/library"
                                -- "${3rd}/busted/library",
                            }
                            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                            -- library = vim.api.nvim_get_runtime_file("", true)
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            }

            -- marksman
            lspconfig.marksman.setup {}
        end
    },
    --  }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        cmd = "LspStart",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        ft = "python,markdown,lua,c,cpp,cuda,rust,javascript,typesript,cmake",
        config = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp_defaults = lspconfig.util.default_config

            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                capabilities
            )

            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
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
                        { "<C-k>",     vim.lsp.buf.signature_help,  buffer = 1, desc = "Display hover signature" },
                        { "<Leader>D", vim.lsp.buf.type_definition, buffer = 1, desc = "Type definition" },
                        {
                            "<Leader>f",
                            function()
                                vim.lsp.buf.format { async = true }
                            end,
                            buffer = 1,
                            desc = "Format code"
                        },
                        { "<Leader>rn", vim.lsp.buf.rename,               buffer = 1, desc = "Rename all references to the symbol" },
                        { "<Leader>w",  group = "[LSP] Workspace" },
                        { "<Leader>wa", vim.lsp.buf.add_workspace_folder, buffer = 1, desc = "Add workspace folder" },
                        {
                            "<Leader>wl",
                            function()
                                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                            end,
                            buffer = 1,
                            desc = "List workspace folders"
                        },
                        { "<Leader>wr", vim.lsp.buf.remove_workspace_folder, buffer = 1, desc = "Remove workspace folder" },
                        { "K",          vim.lsp.buf.hover,                   buffer = 1, desc = "Display hover information" },
                        { "gD",         vim.lsp.buf.declaration,             buffer = 1, desc = "Go to declaration" },
                        { "gd",         vim.lsp.buf.definition,              buffer = 1, desc = "Go to definition" },
                        { "gi",         vim.lsp.buf.implementation,          buffer = 1, desc = "Go to implementation" },
                        { "gr",         vim.lsp.buf.references,              buffer = 1, desc = "Go to references" },
                        { "<Leader>ca", vim.lsp.buf.code_action,             buffer = 1, desc = "Code action",              mode = { "n", "v" } },
                    })
                end,
            })
        end
    },

    -- }}}

    --------------------------------------------------------------------------
    -- {{{ nvim-cmp
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
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
                    { name = 'nvim_lsp',      priority = 1000 },
                    { name = 'vsnip',         priority = 900 },
                    { name = 'buffer',        priority = 800 },
                    { name = 'path',          priority = 700 },
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
    -- {{{ none-ls.vim
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
    -- {{{ vim-doge
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

}
