return {
    "nvimtools/none-ls.nvim", -- configure formatters & linters
    lazy = true,
    -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local mason_null_ls = require("mason-null-ls")

        local null_ls = require("null-ls")

        local null_ls_utils = require("null-ls.utils")

        mason_null_ls.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "black", -- python formatter
                "ruff",
                "mypy",
                "pylint", -- python linter
                "eslint_d", -- js linter
                -- "csharpier",
                -- "semgrep", -- C# linter
            },
        })
        local code_actions = null_ls.builtins.code_actions
        -- for conciseness
        local formatting = null_ls.builtins.formatting -- to setup formatters
        local diagnostics = null_ls.builtins.diagnostics -- to setup linters

        -- to setup format on save
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        -- configure null_ls
        null_ls.setup({
            -- add package.json as identifier for root (for typescript monorepos)
            debug = true,
            root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
            -- setup formatters & linters
            sources = {
                --  to disable file types use
                --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
                code_actions.shellcheck,
                code_actions.cspell,
                code_actions.marksman,
                formatting.prettier.with({
                    extra_filetypes = { "svelte" },
                    extra_args = { "--tab-width", "4" },
                }), -- js/ts formatter
                formatting.stylua, -- lua formatter
                formatting.isort,
                formatting.black,
                formatting.shfmt,
                -- formatting.djlint,
                formatting.jq,
                -- formatting.csharpier,
                -- diagnostics.semgrep,
                --
                formatting.marksman,
                diagnostics.marksman,
                diagnostics.pylint.with({
                    extra_args = { "--disable", "C0114,c0115,c0116,c0301,w1203,w0703" },
                    env = function(params)
                        return { PYTHONPATH = params.root }
                    end,
                }),
                diagnostics.codespell.with({ filetypes = { "python" } }),
                diagnostics.mypy,
                diagnostics.flake8.with({
                    extra_args = { "--ignore", "e501", "--select", "e126" },
                }),
                diagnostics.shellcheck,
                diagnostics.eslint.with({ -- js/ts linter
                    condition = function(utils)
                        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
                    end,
                }),
                diagnostics.eslint_d.with({ -- js/ts linter
                    condition = function(utils)
                        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
                    end,
                }),
            },
            -- configure format on save
            on_attach = function(current_client, bufnr)
                if current_client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                filter = function(client)
                                    --  only use null-ls for formatting instead of lsp server
                                    return client.name == "null-ls"
                                end,
                                bufnr = bufnr,
                            })
                        end,
                    })
                end
            end,
        })
    end,
}
