return {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use

    -- "christoomey/vim-tmux-navigator",   -- tmux & split window navigation

    "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim",        -- optional
            "ibhagwan/fzf-lua",              -- optional
        },
        config = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = function(_, opts)
            -- Other blankline configuration here
            return require("indent-rainbowline").make_opts(opts, {
                -- How transparent should the rainbow colors be. 1 is completely opaque, 0 is invisible. 0.07 by default
                color_transparency = 0.25,
                -- The 24-bit colors to mix with the background. Specified in hex.
                -- { 0xffff40, 0x79ff79, 0xff79ff, 0x4fecec, } by default
                colors = {
                    0x0077be,
                    0x6840dd,
                    0x9200a1,
                    0xdd0077,
                    0x9932cc,
                    0x6a0dad,
                    0x4b0082,
                    0xbb76ff,
                },
            })
        end,
        dependencies = {
            "TheGLander/indent-rainbowline.nvim",
        },
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        version = "*",
        opts = {
            options = {
                mode = "tabs",
                separator_style = "slant",
            },
        },
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
    { "petertriho/nvim-scrollbar",       lazy = true },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        -- theme = "tokyonight",
        lazy = true,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    { "folke/neodev.nvim",               opts = {} },
    { "akinsho/toggleterm.nvim",         version = "*", config = true },
    -- { "phaazon/hop.nvim", branch = "v2", lazy = true },
    { "smoka7/hop.nvim",                 version = "*" },
    { "eandrju/cellular-automaton.nvim", lazy = false },
    { "rcarriga/nvim-notify",            lazy = true },
    { "kevinhwang91/nvim-hlslens",       lazy = true },
    {
        "aznhe21/actions-preview.nvim",
        config = function() end,
        lazy = true,
    },
    {
        "kylechui/nvim-surround",
        event = { "BufReadPre", "BufNewFile" },
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = true,
    },
    {
        "szw/vim-maximizer",
    },
    {
        "stevearc/aerial.nvim",
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },
    -- ufo, for code folding
    { "kevinhwang91/nvim-ufo",       dependencies = "kevinhwang91/promise-async" },
    { "tzachar/local-highlight.nvim" },
    { "folke/flash.nvim",            event = "VeryLazy" },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },
}
