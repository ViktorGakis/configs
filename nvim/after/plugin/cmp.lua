-- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
local cmp = require("cmp")
local zero = require("lsp-zero")
-- local lsp = zero.preset({})
local lsp = zero.preset("recommended")
local lspkind = require("lspkind")
local lspconfig = require("lspconfig")
-- import nvim-autopairs completion functionality

local schemas = require("schemastore")

-- local source_mapping = {
--     buffer = "[Buffer]",
--     nvim_lsp = "[LSP]",
--     luasnip = "[Lua]",
--     vsnip = "[Vsnip]",
--     path = "[Path]",
--     ultisnips = "[Usnip]",
-- }
--
-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

lspkind.init({})

-- vim.keymap.set(
--     "n",
--     "<leader>k",
--     ":LspOverloadsSignature<CR>",
--     { desc = "Toggle Method Signature Overloads", silent = true }
-- )
-- vim.keymap.set(
--     "i",
--     "<leader>k",
--     "<CMD>:LspOverloadsSignature<CR>",
--     { desc = "Toggle Method Signature Overloads", silent = true }
-- )

vim.keymap.set({ "n" }, "<leader>ls", function()
    require("lsp_signature").toggle_float_win()
end, { silent = true, desc = "toggle signature" })

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr, preserve_mappings = true })
    -- lsp.default_keymaps({ buffer = bufnr, preserve_mappings = true })
    lsp.buffer_autoformat()

    vim.keymap.set({ "n", "x" }, "<leader>lf", function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end, { desc = "Format Buffer", silent = true })

    if client.server_capabilities.signatureHelpProvider then
        local overloads = require("lsp-overloads")
        overloads.setup(client, {})

        -- overloads.setup(client, {
        -- 	keymaps = {
        -- 		-- next_signature = "<C-j>",
        -- 		next_signature = '<leader>lk',
        -- 		-- previous_signature = "<C-k>",
        -- 		previous_signature = "<leader>lj",
        -- 		next_parameter = '<C-l>',
        -- 		previous_parameter = '<C-h>',
        -- 		close_signature = "<A-s>"
        -- 	},
        -- 	display_automatically = true
        -- })
    end
    -- vim.keymap.set('n', '<leader>le', "<cmd>Telescope lsp_references<CR>", {buffer = true})
    -- bind('n', '<leader>r', '<cmd> lua vim.lsp.buf.rename()<cr>')
end)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local neodev = require("neodev")

        neodev.setup({
            library = {
                plugins = {
                    "nvim-dap-ui",
                    types = true,
                },
            },
        })

        local signature = require("lsp_signature")

        signature.setup({
            bind = true,
            handler_opts = {
                border = "rounded",
            },
            max_width = 130,
            wrap = true,
            floating_window = false,
            always_trigger = false,
        })
    end,
})

lspconfig.jsonls.setup({
    settings = {
        json = {
            schemas = schemas.json.schemas(),
            validate = { enable = true },
        },
    },
})

lspconfig.yamlls.setup({
    settins = {
        yamlls = {
            schemas = schemas.yaml.schemas(),
        },
    },
})

-- lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = true,
})

local function toggleLines()
    local new_value = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_value, virtual_text = not new_value })
    return new_value
end

vim.keymap.set("n", "<leader>lu", toggleLines, { desc = "Toggle Underline Diagnostics", silent = true })

lsp.setup()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        require("lsp_lines").setup()

        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        local luasnip = require("luasnip")
        luasnip.config.set_config({
            enable_autosnippets = true,
            history = true,
        })
        luasnip.config.setup({
            enable_autosnippets = true,
            history = true,
        })

        function create_namespace_from_path(path)
            return "namespace " .. path:gsub("[a-zA-Z]:[\\/]", ""):gsub("[\\/]", ".") .. ";"
        end

        function get_namespace()
            local fname = vim.api.nvim_buf_get_name(0)
            print("fname: " .. fname)
            local util = require("lspconfig.util")
            local path = util.root_pattern("*.csproj")(fname)
                or util.root_pattern("*.sln")(fname)
                or util.root_pattern("*.sln")("./")
                or util.root_pattern("*.csproj")("./")
                or util.root_pattern("*.slnx")
            print("path: ", path)

            if path == nil then
                path = ""
            end

            local result = fname:gsub(path .. "/", ""):gsub(path .. "\\", "")
            print("temp-result: " .. result)
            local no_fname = result:gsub("[\\/]?[a-zA-Z0-9_@]+.cs$", "")

            print("no_fname: " .. no_fname)

            local namespace = create_namespace_from_path(no_fname)
            return namespace
        end

        local function get_class_name()
            local start_index, end_index, file_name = string.find(vim.api.nvim_buf_get_name(0), "([a-zA-Z_@<>0-9]+).cs")
            local name = file_name:gsub(".cs", ""):gsub("/", ""):gsub("\\", "")

            return name
        end

        local function get_class_with_namespace()
            local class_name = get_class_name()
            local namespace_name = get_namespace()
            local type = "class"

            if class_name:sub(1, 1) == "I" then
                type = "interface"
            end

            return {
                namespace_name,
                [[]],
                "public " .. type .. " " .. class_name,
                [[{]],
                [[]],
                "}",
            }
        end

        luasnip.add_snippets(nil, {
            cs = {
                luasnip.snippet({
                    trig = "namespace",
                    name = "add namesapce",
                    dscr = "Add namespace",
                }, {
                    luasnip.function_node(get_namespace, {}),
                }),
                luasnip.snippet({
                    trig = "class",
                    name = "class with namesapce",
                    dscr = "class with namesapce",
                }, {
                    luasnip.function_node(get_class_with_namespace, {}),
                }),
            },
        })

        luasnip.setup()

        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp_action = zero.cmp_action()
        -- make autopairs and completion work together
        --
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },

            windows = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ["<C-y>"] = cmp.config.disable,
                -- ["<C-e>"] = cmp.config.disable,
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- elseif vim.fn["vsnip#available"](1) then
                        --     vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)", ""))
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                        -- elseif vim.fn["vsnip#available"](1) then
                        --     vim.fn.feedkeys(t("<Plug>(vsnip-expand-or-jump)", ""))
                    else
                        fallback()
                    end
                end, {
                    "i",
                    "s",
                }),
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                -- check if the below <c-l> is needed. It was added as a test
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "vsnip" },
            }, { { name = "buffer" }, { name = "path" } }),
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                    -- vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
                    return kind
                end,
            },
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "nvim_lsp_document_symbol" }, { name = "buffer" } },
            }),

            cmp.setup.cmdline({ ":", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Main", "!" },
                        },
                    },
                }),
            }),
        })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local function toSnakeCase(str)
            return string.gsub(str, "%s*[- ]%s*", "_")
        end
    end,
})

-- vscode completion colours
-- gray
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
-- blue
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
-- light blue
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
-- pink
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
-- front
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
