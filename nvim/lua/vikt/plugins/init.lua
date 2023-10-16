return {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use

    "christoomey/vim-tmux-navigator", -- tmux & split window navigation

    "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim", -- required
            "nvim-telescope/telescope.nvim", -- optional
            "sindrets/diffview.nvim", -- optional
            "ibhagwan/fzf-lua", -- optional
        },
        config = true,
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
        "stevearc/dressing.nvim",
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "petertriho/nvim-scrollbar", lazy = true },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        theme = "tokyonight",
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
    { "folke/neodev.nvim", opts = {} },
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    { "phaazon/hop.nvim", branch = "v2", lazy = true },
    { "eandrju/cellular-automaton.nvim", lazy = false },
    { "rcarriga/nvim-notify", lazy = true },
    { "kevinhwang91/nvim-hlslens", lazy = true },
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            vim.keymap.set({ "v", "n" }, "<leader>cr", require("actions-preview").code_actions)
        end,
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
    { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
    -- { "omnisharp-vim" },
}
