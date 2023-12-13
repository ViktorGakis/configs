local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        -- graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
    },
    -- format_on_save = {
    --     lsp_fallback = true,
    --     async = true,
    --     timeout_ms = 500,
    -- },
})

local function formatter()
    conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
    })
end

-- Function to feed the Escape key
local function feedEscapeKey()
    -- The escape key is represented by "\27" in ASCII
    local escapeKey = "\27"

    -- Feed the escape key to Neovim
    vim.api.nvim_feedkeys(escapeKey, "n", false)
end

local function formattingActions()
    -- vim.cmd("normal! ma")
    -- vim.cmd("normal! kh")
    -- feedEscapeKey()
    formatter()
end

local function saveFormat_N()
    local success, errorMessage = pcall(formattingActions)

    -- Perform the final action regardless of the outcome
    -- Write the file
    vim.cmd("w")

    -- Jump to mark
    -- vim.cmd("normal! `a")
    -- Optionally, you can return the success status and error message
    return success, errorMessage
end

local function saveFormat_I()
    feedEscapeKey()
    local success, errorMessage = pcall(formattingActions)
    -- Perform the final action regardless of the outcome
    -- Write the file
    vim.cmd("w")

    -- Jump to mark
    -- vim.cmd("normal! `a")
    -- Optionally, you can return the success status and error message
    return success, errorMessage
end

local map = vim.keymap.set
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

map("n", "<C-S>", saveFormat_N, { desc = "Format And Save" })
-- map("n", "<C-s>", "ma<ESC>kh<leader>mp<cmd>w<CR>`a", { desc = "Format and Save" })format
-- map("i", "<C-s>", "<ESC>ma<ESC>kh<leader>mp<cmd>w<CR>`a", { desc = "Format and Save" })
--
-- vim.keymap.set({ "n", "v" }, "<leader>mp", formatter, { desc = "Format file or range (in visual mode)" })
--
