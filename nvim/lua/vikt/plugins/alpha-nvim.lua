return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██╗  ██╗    ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██║ ██╔╝    ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║█████╔╝     ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██╔═██╗     ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║  ██╗    ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═╝    ",
            "                                                     ",
        }

        -- Set menu
        dashboard.section.buttons.val = {
            -- dashboard.button(
            --     "<leader>ec",
            --     "  > treesitter",
            --     "<cmd>e ~/.config/nvim/after/plugin/treesitter.lua <CR>"
            -- ),
            dashboard.button("<leader>ec", "  > NVIM", "<cmd>e ~/.config/nvim/ <CR>"),
            -- dashboard.button("<M-1>", "  > TMUX", "<cmd>e ~/.tmux.conf <CR>"),
            -- dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
            dashboard.button("<C-n>", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
            -- dashboard.button("<leader>ff>", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
            -- dashboard.button("<leader>fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("<leader>wr", "󰁯  > Restore Session", "<cmd>SessionRestore<CR>"),
            dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
        }

        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
