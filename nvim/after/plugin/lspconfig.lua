-- import lspconfig plugin
local lspconfig = require("lspconfig")

-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local keymap = vim.keymap -- for conciseness

local opts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
    opts.buffer = bufnr

    -- set keybinds
    opts.desc = "Show LSP references"
    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    opts.desc = "Show LSP type definitions"
    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})

-- configure html server
lspconfig["html"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure typescript server with plugin
lspconfig["tsserver"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
        }),
    },
})

-- configure css server
lspconfig["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- lspconfig["pylsp"].setup({
--     on_attach = on_attach,
--     settings = {
--         pylsp = {
--             plugins = {
--                 -- formatter options
--                 black = { enabled = true },
--                 autopep8 = { enabled = false },
--                 yapf = { enabled = false },
--                 -- linter options
--                 pylint = { enabled = true, executable = "pylint" },
--                 pyflakes = { enabled = false },
--                 pycodestyle = { enabled = false },
--                 -- type checker
--                 pylsp_mypy = { enabled = true },
--                 -- auto-completion options
--                 jedi_completion = { fuzzy = true },
--                 -- import sorting
--                 pyls_isort = { enabled = true },
--             },
--         },
--     },
--     flags = {
--         debounce_text_changes = 200,
--     },
--     capabilities = capabilities,
-- })
-- configure python server
-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
lspconfig["pyright"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pyright = {
            autoImportCompletion = true,
        },
        python = {
            analysis = {
                include = { "src/**/*.py" },
                exclude = { "**/node_modules/**", "**/__pycache__/**" },
                autoSearchPaths = true,
                extraPaths = { "./" },
                typeshedPaths = { "./" },
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
                reportMissingTypeStubs = false,
                portOptionalSubscript = "error",
                strict = false,
                strictFunctionTypes = false,
                useLibraryCodeForTypes = true,
                reportUndefinedVariable = false,
            },
            -- diagnostics = {
            --     extra_args = { "--disable", "c0114,c0115,c0116,c0301,w1203,w0703" },
            --     textDocument = {
            --         publishDiagnostics = {
            --             tagSupport = {
            --                 valueSet = { 2 },
            --             },
            --         },
            --     },
            -- },
        },
    },
})
lspconfig["ruff_lsp"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    callback = function()
        vim.lsp.start({
            name = "bash-language-server",
            cmd = { "bash-language-server", "start" },
        })
    end,
})
--
--
-- lspconfig["csharp-language-server"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     enable_roslyn_analysers = true,
--     enable_import_completion = true,
--     organize_imports_on_format = true,
--     filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props" },
-- })

-- lspconfig["omnisharp"].setup({
--     capabilities = capabilities,
--     on_attach = on_attach,
--     enable_roslyn_analysers = true,
--     enable_import_completion = true,
--     organize_imports_on_format = true,
--     filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props" },
-- })
