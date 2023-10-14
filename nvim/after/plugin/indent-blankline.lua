local indent = require("ibl")

indent.setup({
    exclude = {
        filetypes = {
            "help",
            "startify",
            "dashboard",
            "lazy",
            "neogitstatus",
            "NvimTree",
            "Trouble",
            "text",
        },
        buftypes = {
            "terminal",
            "nofile",
        },
    },
})
