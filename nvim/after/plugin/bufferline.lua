require("bufferline").setup({
    options = {
        mode = "buffers",

        offsets = {
            {
                filetype = "NvimTree",
                text = "FileExplorer",
                highlight = "Directory",
                separator = true,
            },
        },
    },
})

local map = vim.keymap.set
map("n", "<leader>q", "<cmd> bd <CR>", { desc = "Close buffer" })
map("n", "<leader>bb", ":BufferLinePick <CR>", { desc = "Pick Buffer" })
map("n", "<Tab>", ":BufferLineCycleNext <CR>", { desc = "Next Buffer", silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev <CR>", { desc = "Previous Buffer", silent = true })
map(
    "n",
    "<leader>b1",
    ":lua require'bufferline'.move_to(1)<CR>",
    { desc = "Move Buffer to 1", silent = true, noremap = true }
)
map(
    "n",
    "<leader>b2",
    ":lua require'bufferline'.move_to(-1)<CR>",
    { desc = "Move Buffer to -1", silent = true, noremap = true }
)

map(
    "n",
    "<leader>bse",
    ":lua require'bufferline'.sort_by('extension') <CR>",
    { desc = "Sort buffers by extension", silent = true, noremap = true }
)
map(
    "n",
    "<leader>bsd",
    ":lua require'bufferline'.sort_by('directory') <CR>",
    { desc = "Sort buffers by directory", silent = true, noremap = true }
)
map(
    "n",
    "<leader>bst",
    ":lua require'bufferline'.sort_by('tabs') <CR>",
    { desc = "Sort buffers by tabs", silent = true, noremap = true }
)

map(
    "n",
    "<leader>bcr",
    ":BufferLineCloseRight <CR>",
    { desc = "Close all visible buffers to the right", silent = true, noremap = true }
)
map(
    "n",
    "<leader>bcl",
    ":BufferLineCloseLeft <CR>",
    { desc = "Close all visible buffers to the left", silent = true, noremap = true }
)
map(
    "n",
    "<leader>bca",
    ":BufferLineCloseOthers <CR>",
    { desc = "Close all visible buffers except current", silent = true, noremap = true }
)
