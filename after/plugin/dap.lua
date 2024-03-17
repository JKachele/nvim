local status_ok, masonDap = pcall(require, "mason-nvim-dap")
if not status_ok then
    return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

-- dapui.setup()
dapui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has "nvim-0.7",
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
                -- "stacks",
                -- "watches",
            },
            size = 40, -- 40 columns
            position = "right",
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
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
}

masonDap.setup({
    automatic_setup = true,
})

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/jkachele/.local/share/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { "-i", "dap" },
}

dap.configurations.cpp = {
    sname = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    setupCommands = {
        {
            text = '-enable-pretty-printing',
            description =  'enable pretty printing',
            ignoreFailures = false
        },
    },
}

dap.configurations.c = {
    {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to Executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
    },
}

require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        pythonPath = function()
            return '/usr/bin/python'
        end;
    },
}

dap.configurations.rust = dap.configurations.cpp

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close {}
end
