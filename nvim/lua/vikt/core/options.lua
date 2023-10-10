local opt = vim.opt
local g = vim.g
local o = vim.o

g.mapleader = " "
g.maplocalleader = " "

-- tabs & indentation
opt.expandtab = true -- expand tab to spaces
-- copy indent from current line when starting new one
-- opt.autoindent = true

-- line wrapping
opt.wrap = true
opt.breakindent = true
-- Set the minimum indent for wrapped lines (adjust this value as needed)
opt.breakindentopt = "shift:4"
opt.textwidth = 999999999
opt.showbreak = "  "
-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

---- backspace
-- allow backspace on indent, end of line or insert mode start position
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

g.rust_recommended_style = false
g.targets_nl = "nh"

-- o.clipboard = "unnamedplus"
o.timeoutlen = 500
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
o.hlsearch = true

o.number = true
o.relativenumber = true
o.tabstop = 4
o.shiftwidth = 4
o.smartindent = true
o.mouse = "a"
o.ignorecase = true
o.smartcase = true
o.colorcolumn = ""
o.syntax = "enable"
o.termguicolors = true
o.background = "dark"

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
