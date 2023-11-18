return {
    -- {
    --   "bluz71/vim-nightfly-guicolors",
    --   priority = 1000, -- make sure to load this before all the other start plugins
    --   config = function()
    -- -- load the colorscheme here
    -- vim.cmd([[colorscheme nightfly]])
    --   end,
    -- },
    -- {
    --     "lunarvim/synthwave84.nvim",
    --     priority = 1000,
    --
    --     config = function()
    --         -- #060217
    --         -- #1a1a1a
    --         -- #0f0f0f
    --         -- #030302
    --         local clr = "#030302"
    --         local bg = clr
    --         local bg_dark = clr
    --         -- #4A306D
    --         -- "#143652"
    --         -- #443266
    --         local bg_highlight = "#143652"
    --         -- local bg_search = "#0A64AC"
    --         -- local bg_visual = "#275378"
    --         -- local fg = "#CBE0F0"
    --         -- local fg_dark = "#B4D0E9"
    --         -- local fg_gutter = "#627E97"
    --         -- local border = "#547998"
    --
    --         require("synthwave84").setup({
    --             glow = {
    --                 error_msg = true,
    --                 type2 = true,
    --                 func = true,
    --                 keyword = true,
    --                 operator = true,
    --                 buffer_current_target = true,
    --                 buffer_visible_target = true,
    --                 buffer_inactive_target = true,
    --             },
    --             on_colors = function(colors)
    --                 colors.bg = bg
    --                 colors.bg_dark = bg_dark
    --                 colors.bg_float = bg_dark
    --                 colors.bg_highlight = bg_highlight
    --                 colors.bg_popup = bg_dark
    --                 -- colors.bg_search = bg_search
    --                 colors.bg_sidebar = bg_dark
    --                 colors.bg_statusline = bg_dark
    --                 -- colors.bg_visual = bg_visual
    --                 -- colors.border = border
    --                 -- colors.fg = fg
    --                 colors.fg_dark = fg_dark
    --                 -- colors.fg_float = fg
    --                 -- colors.fg_gutter = fg_gutter
    --                 colors.fg_sidebar = fg_dark
    --             end,
    --         })
    --         -- load the colorscheme here
    --         vim.cmd([[colorscheme synthwave84 ]])
    --     end,
    -- },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            -- #060217
            -- #1a1a1a
            -- #0f0f0f
            -- #030302
            -- local clr = "#030302"
            local clr = "#0c0c0d"
            local bg = clr
            local bg_dark = clr
            -- #4A306D
            -- "#143652"
            -- #443266
            local bg_highlight = "#143652"
            local bg_search = "#0A64AC"
            local bg_visual = "#275378"
            -- local fg = "#CBE0F0"
            -- local fg_dark = "#B4D0E9"
            -- local fg_gutter = "#627E97"
            -- local border = "#547998"
            --
            require("tokyonight").setup({
                style = "night",
                on_colors = function(colors)
                    -- colors.hint = b
                    colors.bg = bg
                    colors.bg_dark = bg_dark
                    colors.bg_float = bg_dark
                    colors.bg_highlight = bg_highlight
                    colors.bg_popup = bg_dark
                    colors.bg_search = bg_search
                    colors.bg_sidebar = bg_dark
                    colors.bg_statusline = bg_dark
                    colors.bg_visual = bg_visual
                    -- colors.border = border
                    -- colors.fg = fg
                    colors.fg_dark = fg_dark
                    -- colors.fg_float = fg
                    -- colors.fg_gutter = fg_gutter
                    colors.fg_sidebar = fg_dark
                end,
            })
            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
}
