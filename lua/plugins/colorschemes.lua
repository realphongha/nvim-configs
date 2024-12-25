return {
    --------------------------------------------------------------------------
    -- {{{ catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        build = ":CatppuccinCompile",
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = {     -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
            term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = {
                enabled = false,            -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15,          -- percentage of the shade to apply to the inactive window
            },
            no_italic = false,              -- Force no italic
            no_bold = false,                -- Force no bold
            no_underline = false,           -- Force no underline
            styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" },    -- Change the style of comments
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                cmp = true,
                nvimtree = true,
                treesitter = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
            }
        },
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ rose-pine
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        opts = {
            --- @usage 'auto'|'main'|'moon'|'dawn'
            variant = 'auto',
            --- @usage 'main'|'moon'|'dawn'
            dark_variant = 'main',
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = false,
            disable_float_background = false,
            disable_italics = true,

            -- Change specific vim highlight groups
            -- https://github.com/rose-pine/neovim/wiki/Recipes
            highlight_groups = {
                -- ColorColumn = { bg = 'rose' },

                -- Blend colours against the "base" background
                CursorLine = { bg = 'foam', blend = 10 },
                StatusLine = { fg = 'love', bg = 'love', blend = 10 },

                -- By default each group adds to the existing config.
                -- If you only want to set what is written in this config exactly,
                -- you can set the inherit option:
                -- Search = { bg = 'gold', inherit = false },
            }
        }
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ tokyonight
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day",    -- The theme is used when the background is set to light
            transparent = false,    -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark",            -- style for sidebars, see below
                floats = "dark",              -- style for floating windows
            },
            sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false,             -- dims inactive windows
            lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

            --- You can override specific color groups to use other groups or a hex color
            --- function will be called with a ColorScheme table
            ---@param colors ColorScheme
            on_colors = function(colors) end,

            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with a Highlights and ColorScheme table
            ---@param highlights Highlights
            ---@param colors ColorScheme
            on_highlights = function(highlights, colors) end,
        }
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ kanagawa.nvim
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = true,
        build = ":KanagawaCompile",
        opts = {
            compile = true,   -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,   -- do not set background color
            dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors) -- add/modify highlights
                return {}
            end,
            theme = "wave",    -- Load "wave" theme when 'background' option is not set
            background = {     -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus"
            },
        }
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ no-clown-fiesta.nvim
    {
        "aktersnurra/no-clown-fiesta.nvim",
        name = "no-clown-fiesta",
        lazy = true,
        config = function()
            local plugin = require "no-clown-fiesta"
            plugin.setup({
                styles = {
                    type = { bold = true },
                    lsp = { underline = false },
                    match_paren = { underline = true },
                },
            })
            return plugin.load()
        end
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ flow.nvim
    {
        "0xstepit/flow.nvim",
        name = "flow",
        lazy = true,
        tag = "vX.0.0",
        opts = {
            -- Your configuration options here.
        },
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ gruvbox
    {
        "morhetz/gruvbox",
        name = "gruvbox",
        lazy = true,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ monokai
    {
        "tanvirtin/monokai.nvim",
        name = "monokai",
        lazy = true,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ peaksea
    {
        "calincru/peaksea.vim",
        name = "peaksea",
        lazy = true,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ solarized
    {
        "altercation/vim-colors-solarized",
        name = "solarized",
        lazy = true,
    },
    -- }}}
}
