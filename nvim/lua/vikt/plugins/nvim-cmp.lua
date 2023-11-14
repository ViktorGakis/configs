return {
    -- Autocompletion
    "hrsh7th/nvim-cmp",

    --  Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip", --
    "saadparwaiz1/cmp_luasnip",

    -- Adds LSP completion capabilities
    "hrsh7th/cmp-nvim-lsp",

    -- Sources
    "hrsh7th/cmp-path",    -- source for file system paths
    "hrsh7th/cmp-cmdline", -- source for cmd

    "hrsh7th/cmp-vsnip",   -- source for file system paths
    -- "hrsh7th/vim-vsnip",   -- useful snippets

    -- nvim-cmp source for textDocument/documentSymbol via nvim-lsp.
    -- The purpose is the demonstration customize / search by nvim-cmp.
    "hrsh7th/cmp-nvim-lsp-document-symbol",

    -- Actual snippets
    "honza/vim-snippets",
    "rafamadriz/friendly-snippets",

    -- vs-code like pictograms
    "onsails/lspkind.nvim",

    -- "quangnguyen30192/cmp-nvim-ultisnips",
    event = "InsertEnter",
    dependencies = {},
}
