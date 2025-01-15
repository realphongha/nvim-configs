return {
    --------------------------------------------------------------------------
    -- {{{ undotree
    {
        "mbbill/undotree",
        lazy = true,
        keys = {
            { "u", mode = "n" }
        },
        config = function()
            require("which-key").register({
                ["<leader>u"] = {
                    ":UndotreeToggle<CR>",
                    "Toggle undotree",
                    mode = "n",
                    noremap = true,
                },
            })
        end
    },

    -- }}}

    --------------------------------------------------------------------------
    -- {{{ vim-sleuth
    {
        "tpope/vim-sleuth",
        lazy = false,
    },
    -- }}}
    --

    -- {{{ ts-comments
    {
      "folke/ts-comments.nvim",
      opts = {},
      event = "VeryLazy",
      enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    -- }}}
    --

    -- {{{ multicursor.nvim
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()
            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({"n", "v"}, "<up>",
                function() mc.lineAddCursor(-1) end)
            set({"n", "v"}, "<down>",
                function() mc.lineAddCursor(1) end)
            set({"n", "v"}, "<leader><up>",
                function() mc.lineSkipCursor(-1) end)
            set({"n", "v"}, "<leader><down>",
                function() mc.lineSkipCursor(1) end)

            -- Add or skip adding a new cursor by matching word/selection
            set({"n", "v"}, "<leader>n",
                function() mc.matchAddCursor(1) end)
            set({"n", "v"}, "<leader>s",
                function() mc.matchSkipCursor(1) end)
            set({"n", "v"}, "<leader>N",
                function() mc.matchAddCursor(-1) end)
            set({"n", "v"}, "<leader>S",
                function() mc.matchSkipCursor(-1) end)

            -- Add all matches in the document
            set({"n", "v"}, "<leader>A", mc.matchAllAddCursors)

            -- You can also add cursors with any motion you prefer:
            -- set("n", "<right>", function()
            --     mc.addCursor("w")
            -- end)
            -- set("n", "<leader><right>", function()
            --     mc.skipCursor("w")
            -- end)

            -- Rotate the main cursor.
            set({"n", "v"}, "<left>", mc.nextCursor)
            set({"n", "v"}, "<right>", mc.prevCursor)

            -- Delete the main cursor.
            set({"n", "v"}, "<leader>x", mc.deleteCursor)

            -- Add and remove cursors with control + left click.
            set("n", "<c-leftmouse>", mc.handleMouse)

            -- Easy way to add and remove cursors using the main cursor.
            set({"n", "v"}, "<c-q>", mc.toggleCursor)

            -- Clone every cursor and disable the originals.
            set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors)

            set("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <esc> handler.
                end
            end)

            -- bring back cursors if you accidentally clear them
            set("n", "<leader>gv", mc.restoreCursors)

            -- Align cursor columns.
            set("n", "<leader>a", mc.alignCursors)

            -- Split visual selections by regex.
            set("v", "S", mc.splitCursors)

            -- Append/insert for each line of visual selections.
            set("v", "I", mc.insertVisual)
            set("v", "A", mc.appendVisual)

            -- match new cursors within visual selections by regex.
            set("v", "M", mc.matchCursors)

            -- Rotate visual selection contents.
            set("v", "<leader>t",
                function() mc.transposeCursors(1) end)
            set("v", "<leader>T",
                function() mc.transposeCursors(-1) end)

            -- Jumplist support
            set({"v", "n"}, "<c-i>", mc.jumpForward)
            set({"v", "n"}, "<c-o>", mc.jumpBackward)

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, "MultiCursorCursor", { link = "Cursor" })
            hl(0, "MultiCursorVisual", { link = "Visual" })
            hl(0, "MultiCursorSign", { link = "SignColumn"})
            hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
            hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
            hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ glow.nvim
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        ft = "markdown",
        config = function()
            require('glow').setup({
                {
                    glow_path = "",                -- will be filled automatically with your glow bin in $PATH, if any
                    install_path = "~/.local/bin", -- default path for installing glow binary
                    border = "shadow",             -- floating window border config
                    style = "dark|light",          -- filled automatically with your current editor background, you can override using glow json style
                    pager = false,
                    width = 80,
                    height = 100,
                    width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
                    height_ratio = 0.7,
                }
            })
        end,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            plugins = {
                marks = true,     -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                spelling = {
                    enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true,    -- adds help for operators like d, y, ...
                    motions = true,      -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true,      -- default bindings on <c-w>
                    nav = true,          -- misc bindings to work with windows
                    z = true,            -- bindings for folds, spelling and others prefixed with z
                    g = true,            -- bindings for prefixed with g
                },
            },
            -- add operators that will trigger motion and text object completion
            -- to enable all native operators, set the preset / operators plugin above
            operators = { gc = "Comments" },
            key_labels = {
                -- override the label used to display some keys. It doesn't effect WK in any other way.
                -- For example:
                -- ["<space>"] = "SPC",
                -- ["<cr>"] = "RET",
                -- ["<tab>"] = "TAB",
            },
            motions = {
                count = true,
            },
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            popup_mappings = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>",   -- binding to scroll up inside the popup
            },
            window = {
                border = "single",        -- none, single, double, shadow
                position = "bottom",      -- bottom, top
                margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
                zindex = 1000,            -- positive value to position WhichKey above other floating windows.
            },
            layout = {
                height = { min = 4, max = 25 },                                               -- min and max height of the columns
                width = { min = 20, max = 50 },                                               -- min and max width of the columns
                spacing = 3,                                                                  -- spacing between columns
                align = "left",                                                               -- align columns left, center or right
            },
            ignore_missing = false,                                                           -- enable this to hide mappings for which you didn't specify a label
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
            show_help = true,                                                                 -- show a help message in the command line for using WhichKey
            show_keys = true,                                                                 -- show the currently pressed key and its label as a message in the command line
            triggers = "auto",                                                                -- automatically setup triggers
            -- triggers = {"<leader>"} -- or specifiy a list manually
            -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
            triggers_nowait = {
                -- marks
                "`",
                "'",
                "g`",
                "g'",
                -- registers
                '"',
                "<c-r>",
                -- spelling
                "z=",
            },
            triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for keymaps that start with a native binding
                i = { "j", "k" },
                v = { "j", "k" },
            },
            -- disable the WhichKey popup for certain buf types and file types.
            -- Disabled by default for Telescope
            disable = {
                buftypes = {},
                filetypes = {},
            },
        },
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ bigfile.nvim
    {
        "LunarVim/bigfile.nvim",
        lazy = false,
        config = function()
            local toggle_big_file = {
                name = "toggle_big_file", -- name
                opts = {
                    defer = false, -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function() -- called to disable the feature
                    vim.g.opening_big_file = true
                    vim.b.opening_big_file = true
                end,
                enable = function() -- called to enable the feature
                    vim.g.opening_big_file = false
                    vim.b.opening_big_file = false
                end,
            }

            local nvim_cmp = {
                name = "nvim_cmp", -- name
                opts = {
                    defer = true, -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function() -- called to disable the feature
                    vim.g.enable_nvim_cmp = false
                end,
                enable = function() -- called to enable the feature
                    vim.g.enable_nvim_cmp = true
                end,
            }

            local nvim_autopairs = {
                name = "nvim_autopairs", -- name
                opts = {
                    defer = false, -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function() -- called to disable the feature
                    require("nvim-autopairs").disable()
                end,
                enable = function() -- called to enable the feature
                    require("nvim-autopairs").enable()
                end,
            }

            local codeium = {
                name = "codeium", -- name
                opts = {
                    defer = false, -- set to true if `disable` should be called on `BufReadPost` and not `BufReadPre`
                },
                disable = function() -- called to disable the feature
                    vim.cmd([[Codeium Disable]])
                end,
                enable = function() -- called to enable the feature
                    vim.cmd([[Codeium Enable]])
                end,
            }

            require("bigfile").setup {
                filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
                pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
                features = {  -- features to disable
                    "indent_blankline",
                    "illuminate",
                    "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    "filetype",
                    nvim_cmp,
                    nvim_autopairs,
                    codeium,
                    toggle_big_file
                },
            }
        end
    },
    -- }}}
}
