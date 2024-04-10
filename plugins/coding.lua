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
            require("mason-lspconfig").setup {
                ensure_installed = { "jedi_language_server", "lua_ls" },
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

            -- tsserver
            lspconfig.tsserver.setup {
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
                    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                            Lua = {
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
                                        -- "${3rd}/luv/library"
                                        -- "${3rd}/busted/library",
                                    }
                                    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                    -- library = vim.api.nvim_get_runtime_file("", true)
                                }
                            }
                        })

                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end
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
            require("which-key").register({
                ["<leader>"] = {
                    e = {
                        vim.diagnostic.open_float,
                        "Open diagnostic float window",
                        mode = "n",
                    },
                    q = {
                        vim.diagnostic.setloclist,
                        "Add buffer diagnostics to the location list",
                        mode = "n",
                    },
                },
                ["[d"] = {
                    vim.diagnostic.goto_prev,
                    "Go to next diagnostic",
                    mode = "n",
                },
                ["]d"] = {
                    vim.diagnostic.goto_next,
                    "Go to previous diagnostic",
                    mode = "n",
                },
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
                    require("which-key").register({
                        ["gD"] = {
                            vim.lsp.buf.declaration,
                            "Go to declaration",
                            mode = "n",
                            buffer = ev.buf,
                        },
                        ["gd"] = {
                            vim.lsp.buf.definition,
                            "Go to definition",
                            mode = "n",
                            buffer = ev.buf,
                        },
                        ["K"] = {
                            vim.lsp.buf.hover,
                            "Display hover information",
                            mode = "n",
                            buffer = ev.buf,
                        },
                        ["gi"] = {
                            vim.lsp.buf.implementation,
                            "Go to implementation",
                            mode = "n",
                            buffer = ev.buf,
                        },
                        ["gr"] = {
                            vim.lsp.buf.references,
                            "Go to references",
                            mode = "n",
                            buffer = ev.buf,
                        },
                        ["<C-k>"] = {
                            vim.lsp.buf.signature_help,
                            "Display hover signature",
                            mode = "n",
                            buffer = ev.buf,
                        },
                        ["<Leader>"] = {
                            w = {
                                name = "[LSP] Workspace",
                                a = {
                                    vim.lsp.buf.add_workspace_folder,
                                    "Add workspace folder",
                                    mode = "n",
                                    buffer = ev.buf,
                                },
                                r = {
                                    vim.lsp.buf.remove_workspace_folder,
                                    "Remove workspace folder",
                                    mode = "n",
                                    buffer = ev.buf,
                                },
                                l = {
                                    function()
                                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                    end,
                                    "List workspace folders",
                                    mode = "n",
                                    buffer = ev.buf,
                                },
                            },
                            D = {
                                vim.lsp.buf.type_definition,
                                "Type definition",
                                mode = "n",
                                buffer = ev.buf,
                            },
                            rn = {
                                vim.lsp.buf.rename,
                                "Rename all references to the symbol",
                                mode = "n",
                                buffer = ev.buf,
                            },
                            ca = {
                                vim.lsp.buf.code_action,
                                "Code action",
                                mode = {"n", "v"},
                                buffer = ev.buf,
                            },
                            f = {
                                function()
                                    vim.lsp.buf.format { async = true }
                                end,
                                "Format code",
                                mode = "n",
                                buffer = ev.buf,
                            },
                        },
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
                    null_ls.builtins.completion.spell,

                    -- lua
                    null_ls.builtins.formatting.stylua,

                    -- python
                    null_ls.builtins.formatting.black.with({
                        command = { "black" },
                    }),
                    require("none-ls.diagnostics.flake8"),

                    -- c++
                    null_ls.builtins.formatting.clang_format,
                },
            });
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
            require("which-key").register({
                ["<leader>d"] = {
                    "<Plug>(doge-generate)",
                    "Generate docstring",
                    mode = "n",
                    silent = true,
                },
                ["<TAB>"] = {
                    "<Plug>(doge-comment-jump-forward)",
                    "[vim-doge] Jump forward",
                    mode = { "n", 'i', 's' },
                    silent = true,
                },
                ["<S-TAB>"] = {
                    "<Plug>(doge-comment-jump-backward)",
                    "[vim-doge] Jump backward",
                    mode = { "n", 'i', 's' },
                    silent = true,
                },
            })
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
