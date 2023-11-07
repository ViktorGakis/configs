return {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    config = function()
        local lint = require("lint")
        local eslint = {
            lintCommand = "!eslint_d -f unix --stdin --stdin-filename ${INPUT}",
            lintStdin = true,
            lintFormats = { "%f:%l:%c: %m" },
            lintIgnoreExitCode = true,
            formatCommand = "!eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
            formatStdin = true,
        }
        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            ["javascript.jsx"] = { "eslint_d" },
            typescript = { "eslint_d" },
            ["typescript.tsx"] = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            -- svelte = { "eslint_d" },
            python = { "pylint" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>lt", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
