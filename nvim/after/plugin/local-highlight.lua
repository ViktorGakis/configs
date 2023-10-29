require("local-highlight").setup({
    -- file_types = {'python', 'cpp'},
    disable_file_types = { "tex" },
    hlgroup = "Search",
    cw_hlgroup = nil,
    -- Whether to display highlights in INSERT mode or not
    insert_mode = true,
})

vim.api.nvim_create_autocmd("BufRead", {
    pattern = { "*.*" },
    callback = function(data)
        require("local-highlight").attach(data.buf)
    end,
})

require("local-highlight").match_count(bufnr)
