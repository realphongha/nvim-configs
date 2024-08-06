local leet_arg = "leetcode.nvim"

return {
    --- {{{ leetcode.nvim
    "kawre/leetcode.nvim",
    commit = "05d4153787fab5c6163150d2a0acf29cd1ef297f",
    lazy = (vim.fn.argv()[1] ~= leet_arg),
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        ---@type string
        arg = leet_arg,

        ---@type lc.lang
        lang = "cpp",

        cn = { -- leetcode.cn
            enabled = false, ---@type boolean
            translator = true, ---@type boolean
            translate_problems = true, ---@type boolean
        },

        ---@type lc.storage
        storage = {
            home = vim.fn.stdpath("data") .. "/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },

        ---@type table<string, boolean>
        plugins = {
            non_standalone = false,
        },

        ---@type boolean
        logging = true,

        injector = {
            ["cpp"] = {
                before = {
                    "#include <iostream>",
                    "#include <climits>",
                    "#include <cfloat>",
                    "#include <algorithm>",
                    "#include <string>",
                    "#include <vector>",
                    "#include <unordered_map>",
                    "#include <unordered_set>",
                    "#include <map>",
                    "#include <set>",
                    "",
                    "using namespace std;",
                }
            }
        }, ---@type table<lc.lang, lc.inject>

        cache = {
            update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
        },

        console = {
            open_on_runcode = true, ---@type boolean

            dir = "row", ---@type lc.direction

            size = { ---@type lc.size
                width = "90%",
                height = "75%",
            },

            result = {
                size = "60%", ---@type lc.size
            },

            testcase = {
                virt_text = true, ---@type boolean

                size = "40%", ---@type lc.size
            },
        },

        description = {
            position = "left", ---@type lc.position

            width = "40%", ---@type lc.size

            show_stats = true, ---@type boolean
        },

        hooks = {
            ---@type fun()[]
            ["enter"] = {},

            ---@type fun(question: lc.ui.Question)[]
            ["question_enter"] = {},

            ---@type fun()[]
            ["leave"] = {},
        },

        keys = {
            toggle = { "q", "<Esc>" }, ---@type string|string[]
            confirm = { "<CR>" }, ---@type string|string[]

            reset_testcases = "r", ---@type string
            use_testcase = "U", ---@type string
            focus_testcases = "H", ---@type string
            focus_result = "L", ---@type string
        },

        ---@type boolean
        image_support = false,
    },
    -- config = function ()
    --     vim.cmd("colorscheme catppuccin")
    -- end
    --}}}
}
