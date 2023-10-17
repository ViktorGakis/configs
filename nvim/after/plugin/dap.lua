local dap = require("dap")
local dapui = require("dapui")

---- PYTHON

local path_python = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(path_python)

---- DOTNET
---
vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. "/"
    if vim.g["dotnet_last_proj_path"] ~= nil then
        default_path = vim.g["dotnet_last_proj_path"]
    end
    local path = vim.fn.input("Path to your *proj file", default_path, "file")
    vim.g["dotnet_last_proj_path"] = path
    local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
    print("")
    print("Cmd to execute: " .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print("\nBuild: ✔️ ")
    else
        print("\nBuild: ❌ (code: " .. f .. ")")
    end
end

function findDLLs(path)
    local dllFiles = {}                                         -- Table to store the .dll file paths
    local command = "find " .. path .. " -type f -name '*.dll'" -- Command to execute

    -- Execute the command and get the output handle
    local handle = io.popen(command)
    local result = handle:read("*a") -- Read the entire output as a string
    handle:close()                   -- Close the file handle

    -- Split the result by line and store each line (file path) in the table
    for filePath in string.gmatch(result, "[^\r\n]+") do
        table.insert(dllFiles, filePath)
    end

    return dllFiles -- Return the list of .dll files
end

local function handleDllPathSelection()
    -- If the last DLL path was already selected, confirm if the user wants to change it
    if vim.g["dotnet_last_dll_path"] ~= nil then
        local msg = "Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"]
        if vim.fn.confirm(msg, "&yes\n&no", 2) == 2 then
            return vim.g["dotnet_last_dll_path"]
        end
    end

    local all_dll_paths = findDLLs(vim.fn.getcwd()) -- Get DLLs in the current working directory

    -- Filter the paths to include only those that have 'bin/Debug/' in them
    local dll_paths = {}
    for _, path in ipairs(all_dll_paths) do
        if string.find(path, "bin/Debug/") then
            table.insert(dll_paths, path)
        end
    end

    -- If no .dll files are found after filtering, inform the user and return
    if #dll_paths == 0 then
        vim.api.nvim_err_write("No .dll files found in the 'bin/Debug/' directory.\n")
        return ""
    end

    -- Prepare the message list of all the filtered .dll paths with numbers
    local message = "Found .dll files in 'bin/Debug/':\n"
    for i, path in ipairs(dll_paths) do
        message = message .. i .. ": " .. path .. "\n"
    end

    -- Ask the user to choose a .dll file by entering a number, displaying the list in the prompt
    local selection = vim.fn.input(message .. "Enter the number of the .dll to select: ")
    local selection_number = tonumber(selection)

    -- Validate the input: it should be a number within the correct range
    if selection_number and selection_number >= 1 and selection_number <= #dll_paths then
        -- Save and return the selected path
        vim.g["dotnet_last_dll_path"] = dll_paths[selection_number]
        return vim.g["dotnet_last_dll_path"]
    else
        vim.api.nvim_err_write("Invalid selection.\n")
        return ""
    end
end

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        -- program = function()
        --     return vim.fn.input("Path to dll", vim.fn.getcwd())
        -- end,
        program = function()
            if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                vim.g.dotnet_build_project()
            end
            return handleDllPathSelection()
        end,
    },
}

-- local config = {
--     {
--         type = "coreclr",
--         name = "launch - netcoredbg",
--         request = "launch",
--         program = function()
--             if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
--                 vim.g.dotnet_build_project()
--             end
--             return vim.g.dotnet_get_dll_path()
--         end,
--     },
-- }
--
-- dap.configurations.cs = config
-- dap.configurations.fsharp = config

vim.api.nvim_set_keymap(
    "n",
    "<leader>dpc",
    ":lua vim.g.dotnet_build_project()<CR>",
    { desc = "Build dotnet", noremap = true, silent = true }
)

---- DAPUI

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Use this to override mappings for specific elements
    element_mappings = {
        -- Example:
        -- stacks = {
        --   open = "<CR>",
        --   expand = "o",
        -- }
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "□",
        },
    },
    floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    },
})

---- DAP KEYMAPS
---
local map = vim.keymap.set

map("n", "<leader>dpr", function()
    require("dap-python").test_method()
end, { desc = "Python Dap Test Method" })
vim.fn.sign_define(
    "DapBreakpoint",
    { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)

-- Debugger
map("n", "<leader>dt", function()
    dapui.toggle({})
end, { noremap = true, desc = "Toggle DapUi" })

map({ "n", "v" }, "<leader>de", function()
    dapui.eval()
end, { desc = "Eval dap" })

map({ "n", "v" }, "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })

map({ "n", "v" }, "<leader>db", function()
    dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

map({ "n", "v" }, "<leader>dc", function()
    dap.continue()
end, { desc = "Continue" })

map({ "n", "v" }, "<leader>dC", function()
    dap.run_to_cursor()
end, { desc = "Run to Cursor" })

map({ "n", "v" }, "<leader>dg", function()
    dap.goto_()
end, { desc = "Go to line (no execute)" })

map({ "n", "v" }, "<leader>di", function()
    dap.step_into()
end, { desc = "Step Into" })

map({ "n", "v" }, "<leader>dj", function()
    dap.down()
end, { desc = "Down" })

map({ "n", "v" }, "<leader>dk", function()
    dap.up()
end, { desc = "Up" })

map({ "n", "v" }, "<leader>dl", function()
    dap.run_last()
end, { desc = "Run Last" })

map({ "n", "v" }, "<leader>do", function()
    dap.step_out()
end, { desc = "Step Out" })

map({ "n", "v" }, "<leader>dO", function()
    dap.step_over()
end, { desc = "Step Over" })

map({ "n", "v" }, "<leader>dp", function()
    dap.pause()
end, { desc = "Pause" })

map({ "n", "v" }, "<leader>dr", function()
    dap.repl.toggle()
end, { desc = "Toggle REPL" })

map({ "n", "v" }, "<leader>ds", function()
    dap.session()
end, { desc = "Session" })

map({ "n", "v" }, "<leader>dt", function()
    dap.terminate()
end, { desc = "Terminate" })

map({ "n", "v" }, "<leader>dw", function()
    require("dap.ui.widgets").hover()
end, { desc = "Widgets" })

dap.adapters.coreclr = {
    type = "executable",
    command = "/root/.local/share/nvim/mason/packages/netcoredbg/netcoredbg",
    args = { "--interpreter=vscode" },
}

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
