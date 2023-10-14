-- set leader key to space
local map = vim.keymap.set
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
---------------------
---- Generic Utils
map("n", "<C-d>", "<C-d>zz", { desc = "<C-d> with centering in the end" })
map("n", "<C-u>", "<C-u>zz", { desc = "<C-u> with centering in the end" })
map("n", "<leader>o", "o<ESC>")
map("n", "<leader>O", "O<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })
map("n", "<C-z>", "<nop>")
map("n", "sad", "Adsa")
map(
    "v",
    "<C-p>",
    ":lua local reg_content = vim.fn.getreg() vim.cmd('normal \"_d') vim.fn.setreg('\"', reg_content) vim.cmd('normal p')<CR>",
    { desc = "Replace + Preserve pasting", noremap = true, silent = true }
)
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })

-- map("n", "<leader>fm", format_func, { desc = "LSP formatting" })
map("n", "<C-s>", "<leader>mp<cmd> w <CR>", { desc = "Format and Save" })
map("i", "<C-s>", "<ESC><leader>mp<cmd> w <CR>i", { desc = "Format and Save" })
-- delete single character without copying into register
map("n", "x", '"_x')

-- quick back erasing like VSCODE
map("i", "<M-BS>", "<cmd>norm! db<CR><cmd>star!<CR>")
map("n", "<M-BS>", "db")

map("n", "<leader>ec", "<cmd>e ~/.config/nvim/ <CR>", { desc = "   Configuration" })
-- General Keymaps -------------------

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })

map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- clear search highlights
map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlights" })
-- switch between windows
-- map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Tmux Window left" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Tmux Window right" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Tmux Window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Tmux Window up" })

-- Allow moving cursor through wrapped lines
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

---- window management
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader><tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map("n", "<leader>wm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })

---- NVIMTREE
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

---- TELESCOPE KEYMAPS
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })

-- git
map("n", "<leader>cm", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })

map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })

map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "Pick hidden term" })

---- Sessions
map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
--
map("n", "<leader>b", "<cmd> enew <CR>", { desc = "New buffer" })
map("n", "<leader>ch", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

-- TABUFLINE
--
-- cycle through buffers
map("n", "<tab>", function()
    require("nvchad.tabufline").tabuflineNext()
end, { desc = "Goto next buffer" })

map("n", "<S-tab>", function()
    require("nvchad.tabufline").tabuflinePrev()
end, { desc = "Goto prev buffer" })
-- close buffer + hide terminal buffer
map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer" })

---- comment
--
map("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map(
    "v",
    "<leader>/",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" }
)

---- Python dap
---
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggles Breakpoint" })

map("n", "<leader>dpr", function()
    require("dap-python").test_method()
end, { desc = "Python Dap Test Method" })

map("n", "<leader>cc", function()
    local ok, start = require("indent_blankline.utils").get_current_context(
        vim.g.indent_blankline_context_patterns,
        vim.g.indent_blankline_use_treesitter_scope
    )

    if ok then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
        vim.cmd([[normal! _]])
    end
end, { desc = "Jump to current context" })

----NEOGIT
map("n", "<leader>gs", "<cmd>Neogit kind=vsplit<CR>", { desc = "Open Neogit in vslit" })
-- to make work
--
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "Nvchad themes" })

map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })
