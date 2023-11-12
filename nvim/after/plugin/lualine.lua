local lualine = require("lualine")
local lazy_status = require("lazy.status") -- to configure lazy pending updates count

local function get_lsp_name()
    local msg = "LS Inactive"
    local buf_clients = vim.lsp.get_active_clients()
    -- local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
            return "LS Inactive"
        end
    end
    -- end
    local buf_client_names = {}
    -- local copilot_active = false

    for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)

        -- if client.name == "copilot" then
        --     copilot_active = true
        -- end
    end

    local unique_client_names = vim.fn.uniq(buf_client_names)

    local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

    -- return language_servers;
    -- end

    -- if copilot_active then
    -- 	language_servers = language_servers .. "#SLCopilot#" .. "" --.. "%*"
    -- end
    --
    return language_servers
end

local colors = {
    blue = "#6300db",
    green = "#3EFFDC",
    violet = "#FF61EF",
    yellow = "#FFDA7B",
    red = "#FF4A4A",
    fg = "#c3ccdc",
    -- bg = "#112638",
    bg = "#15173d",
    inactive_bg = "#2c3043",
}

local my_lualine_theme = {
    normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
    },
    inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
    },
}

-- configure lualine with modified theme
lualine.setup({
    options = {
        theme = my_lualine_theme,
        -- theme = "tokyonight",
        icon_enabled = true,
    },
    sections = {
        lualine_x = {
            { get_lsp_name },
            { "selectioncount" },
            {
                lazy_status.updates,
                cond = lazy_status.has_updates,
                color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
            { "aerial" },
        },
        lualine_y = {
            {
                "aerial",
                -- The separator to be used to separate symbols in status line.
                sep = " ) ",

                -- The number of symbols to render top-down. In order to render only 'N' last
                -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                -- be used in order to render only current symbol.
                depth = nil,

                -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                -- a single icon that represents the kind of current symbol is rendered at
                -- the beginning of status line.
                dense = false,

                -- The separator to be used to separate symbols in dense mode.
                dense_sep = ".",

                -- Color the symbol icons.
                colored = true,
            },
        },
    },
})
