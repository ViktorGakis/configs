-- set leader key to space
local map = vim.keymap.set
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "
---------------------
---- Generic Utils
map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Force Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Nukeclear Quit" })
map("n", "<C-d>", "<C-d>zz", { desc = "<C-d> with centering in the end" })
map("n", "<C-u>", "<C-u>zz", { desc = "<C-u> with centering in the end" })
map("n", "<leader>o", "o<ESC>")
map("n", "<leader>O", "O<ESC>")
map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })
map("n", "<C-z>", "<nop>")
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
map("n", "<C-s>", "ma<ESC>kh<leader>mp<cmd>w<CR>`a", { desc = "Format and Save" })
map("i", "<C-s>", "<ESC>ma<ESC>kh<leader>mp<cmd>w<CR>`a", { desc = "Format and Save" })
-- delete single character without copying into register
map("n", "x", '"_x')

-- quick back erasing like VSCODE
map("i", "<M-BS>", "<cmd>norm! db<CR><cmd>star!<CR>")
map("n", "<M-BS>", "db")

map("n", "<leader>ec", "<cmd>e ~/.config/nvim/ <CR>", { desc = "   Configuration" })

-- General Keymaps -------------------

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("i", "<C-d>", "<End>", { desc = "End of line" })
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })

map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

---- clear search highlights
map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlights" })

---- Allow moving cursor through wrapped lines
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })

---- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

---- switch between windows
-- map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

---- window management
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map("n", "<leader>wm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })
