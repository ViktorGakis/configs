local hop = require("hop")
local flash = require("flash")
-- local directions = require("hop.hint").HintDirection
local map = vim.keymap.set
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

hop.setup({ keys = "etovxqpdygfblzhckisuran", case_insensitive = false })
flash.setup({ labels = "etovxqpdygfblzhckisuran" })
-- vim.api.nvim_set_keymap("n", "S", ":HopChar2<cr>", { silent = true })
map("n", "<leader>ss", ":HopWord<cr>", { silent = true, desc = "HopWord" })
-- map("n", "s/", ":HopPattern<cr>", { silent = true, desc = "HopPattern" })
map("n", "sn", ":HopNodes<cr>", { silent = true, desc = "HopNodes" })
map("", "sl", ":HopLine<CR>", { desc = "Hop Line", silent = true })
-- char
-- map("", "f", function()
--     hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })
-- map("", "F", function()
--     hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, { remap = true })
-- vim.keymap.set("", "t", function()
--     hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, { remap = true })
-- vim.keymap.set("", "T", function()
--     hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, { remap = true })

-- local leap = require('leap')
--
-- leap.add_default_mappings()
--

map({ "n", "x", "o" }, "s", function()
    flash.jump()
end, { desc = "Flash" })

map({ "n", "o", "x" }, "S", function()
    require("flash").treesitter()
end, {
    desc = "Flash Treesitter",
})

-- map("o", "<leader>sr", function()
--     flash.remote()
-- end, {
--     desc = "Remote Flash",
-- })

-- map({ "o", "x" }, "<leader>st", function()
--     flash.treesitter_search()
-- end, {
--     desc = "Flash Treesitter Search",
-- })
-- map({ "c" }, "<leader>sc", function()
--     require("flash").toggle()
-- end, { desc = "Toggle Flash Search" })

local Config = require("flash.config")
local Char = require("flash.plugins.char")
for _, motion in ipairs({ "f", "t", "F", "T" }) do
    vim.keymap.set({ "n", "x", "o" }, motion, function()
        require("flash").jump(Config.get({
            mode = "char",
            search = {
                mode = Char.mode(motion),
                max_length = 1,
            },
        }, Char.motions[motion]))
    end)
end
