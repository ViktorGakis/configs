return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" }, lazy = true }, -- Required
            {
                -- Optional
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp", lazy = true }, -- Required
            { "hrsh7th/cmp-nvim-lsp", lazy = true }, -- Required
            { "L3MON4D3/LuaSnip", lazy = true }, -- Required
        },
        lazy = false,
    },
    { "jose-elias-alvarez/null-ls.nvim", lazy = true },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
    },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", lazy = true },
    { "Issafalcon/lsp-overloads.nvim", lazy = true },
    { "ray-x/lsp_signature.nvim", lazy = true },
    { "b0o/schemastore.nvim", lazy = true },
    { "onsails/lspkind.nvim", lazy = true },
}
