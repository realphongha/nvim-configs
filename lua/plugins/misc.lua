local leet_arg = "leetcode.nvim"

return {
    --------------------------------------------------------------------------
    -- {{{ snacks.nvim
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            animate = { enabled = true },
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            dashboard = { enabled = false },
            debug = { enabled = false },
            dim = { enabled = true },
            explorer = { enabled = false },
            git = { enabled = false },
            gitbrowse = { enabled = false },
            image = {
                enabled = true,
                force = true,
                doc = {
                    enabled = true,
                    inline = true,
                    float = true,
                    max_width = 80,
                    max_height = 40,
                },
            },
            indent = { enabled = false },
            input = { enabled = true },
            layout = { enabled = true },
            lazygit = { enabled = false },
            notifier = {
                enabled = true,
                config = function()
                    require("which-key").add({
                        {
                            "<leader>hn",
                            function() Snacks.notifier.show_history() end,
                            desc = "Show notifier history",
                            mode = { "n", "o", "v" }
                        },
                    })
                end
            },
            notify = { enabled = false },
            picker = { enabled = false },
            profiler = { enabled = false },
            quickfile = { enabled = false },
            rename = { enabled = false },
            scope = { enabled = true },
            scratch = { enabled = false },
            scroll = { enabled = true },
            statuscolumn = { enabled = false },
            terminal = { enabled = false },
            toggle = { enabled = true },
            util = { enabled = true },
            win = { enabled = true },
            words = { enabled = true },
            zero = { enabled = false },
        },
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ leetcode.nvim
    {
        "kawre/leetcode.nvim",
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
            lang = "python3", -- cpp, python3

            cn = {            -- leetcode.cn
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
                        "#include <numeric>",
                        "#include <string>",
                        "#include <vector>",
                        "#include <queue>",
                        "#include <stack>",
                        "#include <unordered_map>",
                        "#include <unordered_set>",
                        "#include <map>",
                        "#include <set>",
                        "",
                        "using namespace std;",
                    }
                },
                ["python3"] = {
                    before = {
                        "from collections import *",
                        "from itertools import *",
                        "from bisect import *",
                        "from array import *",
                        "from sortedcontainers import *",
                        "from heapq import *",
                        "from math import *",
                        "",
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
    }
    --}}}
}
