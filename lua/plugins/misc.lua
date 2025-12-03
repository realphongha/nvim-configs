local leet_arg = "leetcode.nvim"

return {
    --------------------------------------------------------------------------
    -- {{{ folke/ts-comments.nvim
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    -- }}}

    --------------------------------------------------------------------------
    -- {{{ folke/snacks.nvim
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
    -- {{{ kawre/leetcode.nvim
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
            arg = leet_arg,
            lang = "python3", -- cpp, python3
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
            },
            image_support = true,
            picker = { provider = "telescope" },
        },
    }
    --}}}
}
