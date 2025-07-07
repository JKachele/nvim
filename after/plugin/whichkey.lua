local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
        return
end

local setup = {
        plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                spelling = {
                        -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        enabled = true,
                        -- how many suggestions should be shown in the list?
                        suggestions = 20,
                },
                -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                -- No actual key bindings are created
                presets = {
                        -- adds help for operators like d, y, ...
                        -- and registers them for motion / text object completion 
                        operators = false,
                        motions = true, -- adds help for motions
                        text_objects = false, -- help for text objects triggered after entering an operator
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        key_labels = {
                -- override the label used to display some keys. It doesn't effect WK in any other way.
                -- For example:
                -- ["<space>"] = "SPC",
                -- ["<cr>"] = "RET",
                -- ["<tab>"] = "TAB",
        },
        icons = {
                -- symbol used in the command line area that shows your active key combo
                breadcrumb = "»",
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
                border = "rounded", -- none, single, double, shadow
                position = "bottom", -- bottom, top
                margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
                padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
                winblend = 0,
        },
        layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        -- hide mapping boilerplate
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
                -- list of mode / prefixes that should never be hooked by WhichKey
                -- this is mostly relevant for key maps that start with a native binding
                -- most people should not need to change this
                i = { "j", "k" },
                v = { "j", "k" },
        },
}

local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
        ["/"] = { "<cmd>lua require(\"Comment.api\").toggle_current_linewise()<CR>", "Comment" },
        ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
        ["b"] = {
                "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
                "Buffers",
        },
        ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
        ["w"] = { "<cmd>w!<CR>", "Save" },
        ["q"] = { "<cmd>q!<CR>", "Quit" },
        ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
        ["f"] = {
                "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
                "Find files",
        },
        ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
        ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
        ["u"] = { "<cmd>UndotreeToggle<cr>", "Undo Tree" },
        ["x"] = {"<cmd>source ~/.config/nvim/init.lua<cr>", "Reload Neovim Config"},

        c = {
                name = "Compile",
                c = {
                        name = "CMake",
                        c = {"<cmd>Task start cmake configure<cr>", "Configure Cmake"},
                        s = {"<cmd>Task set_module_param cmake target<cr>", "Set CMake Target"},
                        r = {"<C-w>l:copen 4<Bar> Task start cmake run<cr>", "Run Cmake"},
                        d = {"<cmd>Task start cmake debug<cr>", "Debug"},
                        x = {"<C-w>l<C-w>j:q<cr>", "Close Quickfix Window"}
                },
                m = {
                        name = "Make",
                        -- a = {"<cmd>Task start make all<cr>", "Make all"},
                        -- b = {"<cmd>Task start make build<cr>", "Make build"},
                        b = {"<cmd>TermExec cmd='make build'<cr>", "Make build"},
                        -- B = {"<cmd>Task start make buildRelease<cr>", "Make build release"},
                        -- r = {"<cmd>Task start make run<cr>", "Make run"},
                        r = {"<cmd>TermExec cmd='make run'<cr>", "Make run"},
                        c = {"<cmd>Task start make clean<cr>", "Make clean"},
                        -- t = {"<cmd>Task start make runTest<cr>", "Make Run Test"},
                        t = {"<cmd>TermExec cmd='make  -s runTest'<cr>", "Make Run Test"},
                        x = {"<C-w>l<C-w>j:q<cr>", "Close Quickfix Window"},
                        a = {
                                name = "Advent of Code",
                                a = {"<cmd>TermExec cmd='./RunAOC.sh run'<cr>", "Run Advent of Code"},
                                t = {"<cmd>TermExec cmd='./RunAOC.sh runWithTest'<cr>", "Run Advent of Code With Test Input"},
                        },
                        A = {"<cmd>TermExec cmd='./RunAOC.sh build'<cr>", "Build Advent of Code"},
                },
                x = {"<C-w>l<C-w>j:q<cr>", "Close Quickfix Window"},
        },

        d = {
                name = "Debug",
                b = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint"},
                B = {"<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear All Breakpoints"},
                c = {"<cmd>lua require'dap'.continue()<cr>", "Continue (F5)"},
                i = {"<cmd>lua require'dap'.step_into()<cr>", "Step Into (F7)"},
                l = {"<cmd>lua require'dap'.run_last()<cr>", "Run last"},
                o = {"<cmd>lua require'dap'.step_over()<cr>", "Step Over (F8)"},
                O = {"<cmd>lua require'dap'.step_out()<cr>", "Step Out (F9)"},
                r = {"<cmd>lua require'dap'.repl.open()<cr>", "Repl"},
                u = {"<cmd>lua require'dapui'.toggle()<cr>", "UI"},
                x = {"<cmd>lua require'dap'.terminate()<cr>", "Terminate"}
        },

        g = {
                name = "Git",
                g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
                j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
                k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
                l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
                p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
                r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
                R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
                s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
                u = {
                        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                        "Undo Stage Hunk",
                },
                o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
                b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                d = {
                        "<cmd>Gitsigns diffthis HEAD<cr>",
                        "Diff",
                },
        },

        m = {
                name = "Markdown preview",
                p = {"<cmd>MarkdownPreview<cr>", "Start Preview"},
                s = {"<cmd>MarkdownPreviewStop<cr>", "Stop Preview"}
        },

        s = {
                name = "Search",
                b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
                h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
                M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
                r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                R = { "<cmd>Telescope registers<cr>", "Registers" },
                k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
                C = { "<cmd>Telescope commands<cr>", "Commands" },
        },

        t = {
                name = "Template",
                c = {
                        name = "C",
                        a = {"<cmd>TemplateInit c/cAdvent<cr>", "C Advent of Code"},
                        m = {"<cmd>TemplateInit c/cMain<cr>", "C Main"},
                        l = {"<cmd>TemplateInit c/cLib<cr>", "C Library"},
                        h = {"<cmd>TemplateInit c/cHeader<cr>", "C Header"},
                },
                j = {
                        name = "Java",
                        c = {"<cmd>TemplateInit java/javaClass<cr>", "Java Class"},
                        m = {"<cmd>TemplateInit java/javaMain<cr>", "Java Main Class"},
                },
                p = {
                        name = "C++",
                        a = {"<cmd>TemplateInit cpp/cppAOC<cr>", "C++ Advent Of Code"},
                        m = {"<cmd>TemplateInit cpp/cppMain<cr>", "C++ Main"},
                },
        },
}

local vopts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
        ["/"] = { "<ESC><CMD>lua require(\"Comment.api\").toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)

-- Add to existing leaders
which_key.register({
        c = "Comment",
        b = "Block Comment",
        g = "Go To Top Of File",
        h = "First char of line",
        l = "End of line",
}, {mode = "n", prefix = "g"})

which_key.register({
        c = "Comment",
        b = "Block Comment",
        g = "Go To Top Of File",
        h = "First char of line",
        l = "End of line",
}, {mode = "v", prefix = "g"})

