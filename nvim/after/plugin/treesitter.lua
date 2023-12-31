local hl = vim.api.nvim_set_hl

local function apply_hl()
    -- hl(0, "MatchParen", { bg = "#e6e6e6", guibg = nil, ctermbg = nil })
    -- hl(0, "@html.tag", { fg = "#b30000", bold = true, italic = true })
    hl(0, "@keyword.function", { fg = "#c300ff", bold = true, italic = true })
    hl(0, "PreProc", { fg = "#c300ff", bold = true, italic = true })
    -- hl("PreProc", { fg = "#4f49fc", bold = true, italic = true })
    hl(0, "@keyword", { fg = "#c300ff", bold = true, italic = true })
    hl(0, "@operator", { fg = "#5bf4fc", bold = true })
    hl(0, "@punctuation.bracket", { fg = "#5bf4fc", bold = true })
    hl(0, "@punctuation.special", { fg = "#5bf4fc", bold = true })
    hl(0, "Statement", { fg = "#b30000", bold = true, italic = true })
    hl(0, "Function", { fg = "#1602f5", bold = true })
    hl(0, "@function", { fg = "#1602f5", bold = true })
    hl(0, "Special", { fg = "#d9d9d9" })
    hl(0, "@Constructor", { fg = "#a84aff" })
    hl(0, "@String", { fg = "#76aa68" })
    hl(0, "@string.documentation", { fg = "#76aa68" })
    hl(0, "@string.escape", { fg = "White" })
    hl(0, "@variable", { fg = "#6f23fc" })
    hl(0, "@variable.builtin", { fg = "#6f23fc" })
    hl(0, "@parameter", { fg = "#117bac" })
    hl(0, "@field", { fg = "#5560ff" })
    hl(0, "@property", { fg = "#5560ff" })
    hl(0, "Constant", { fg = "#82042e" })
    hl(0, "@variable.builtin", { fg = "#a84aff" })
    hl(0, "Constant", { fg = "#a84aff" })
    hl(0, "@Type", { fg = "#00b7ff" })
    hl(0, "@Type.builtin", { fg = "#00b7ff" })
    hl(0, "@Constructor", { fg = "#00b7ff" })
    -- hl("Visual", { fg = "Black", bg = "White", default=true })
    -- hl("Cursorline", { bg = "White", default=true })
    -- hl(0, "Cursor", { bg = "Black", fg = "Black" })
end

apply_hl()

vim.api.nvim_create_autocmd("ColorScheme", {
    -- https://neovim.io/doc/user/api.html
    pattern = "*",
    callback = function()
        apply_hl()
    end,
})

require("ts_context_commentstring").setup({
    enable_autocmd = true,
})
-- to speed up loading instead.
vim.g.skip_ts_context_commentstring_module = true
