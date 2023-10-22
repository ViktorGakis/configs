-- set leader key to space
local map = vim.keymap.set
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

---- NVIMTREE
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map({ "n", "v", "x" }, "<leader>ee", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" })

---- TELESCOPE KEYMAPS
map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fp", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
map("n", "<leader>fk", "<cmd> Telescope keymaps <CR>", { desc = "Find keymaps" })
map("n", "<leader>fc", "<cmd> Telescope commands <CR>", { desc = "Find commands" })
map("n", "<leader>fo", "<cmd> Telescope options <CR>", { desc = "Find options" })
map("n", "<leader>fr", "<cmd> Telescope registers <CR>", { desc = "Find registers" })
map("n", "<leader>fl", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "Find Lsp Symbols" })

-- git
map("n", "<leader>gm", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })

map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })

map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "Pick hidden term" })
---- Sessions
map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })             -- restore last workspace session for current directory
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

----NEOGIT
map("n", "<leader>gs", "<cmd>Neogit kind=vsplit<CR>", { desc = "Open Neogit in vslit" })
-- to make work
--
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "Nvchad themes" })

map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })

map("n", "<leader>m1", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Liquify window1" })
map("n", "<leader>m2", "<cmd>CellularAutomaton game_of_life<CR>", { desc = "Liquify window2" })

-- Move current line / block with Alt-j/k a la vscode.
map("n", "<M-j>", ":m .+1<CR>==", { silent = true })
map("n", "<M-k>", ":m .-2<CR>==", { silent = true })
-- map("n", "<C-a>", "ggVG", { desc = "Select All Lines" })

-- Better line / block movement
-- map("n", "<M-j>", ":m '>+1<CR>gv-gv", { silent = true })
-- map("n", "<M-k>", ":m '<-2<CR>gv-gv", { silent = true })

-- Better indenting in Visual mode
map("v", ">", ">gv")
map("v", "<", "<gv")

map({ "n", "v" }, "<leader>la", require("actions-preview").code_actions)
map({ "v", "n" }, "<leader>cr", require("actions-preview").code_actions)