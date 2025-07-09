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
        icons = {
                -- symbol used in the command line area that shows your active key combo
                breadcrumb = "»",
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
        },
        keys = {
                scroll_down = "<c-d>", -- binding to scroll down inside the popup
                scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        win = {
                border = "rounded", -- none, single, double, shadow
                padding = { 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
        },
        filter = function(mapping)
            -- example to exclude mappings without a description
            -- return mapping.desc and mapping.desc ~= ""
            return true
        end,
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = {
            { "<auto>", mode = "nixsotc" },
        },
        -- triggers_blacklist = {
        --         -- list of mode / prefixes that should never be hooked by WhichKey
        --         -- this is mostly relevant for key maps that start with a native binding
        --         -- most people should not need to change this
        --         i = { "j", "k" },
        --         v = { "j", "k" },
        -- },
        disable = {
            ft = {},
            bt = {},
        },
}
which_key.setup(setup)

which_key.add({
    { "<leader>/", '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
        desc = "Comment", nowait = true, remap = false },
    { "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
        desc = "Comment", mode = "v", nowait = true, remap = false },
    { "<leader>a", "<cmd>Alpha<cr>",
        desc = "Alpha", nowait = true, remap = false },
    { "<leader>b",
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        desc = "Buffers", nowait = true, remap = false },
    { "<leader>e", "<cmd>NvimTreeToggle<cr>",
        desc = "Explorer", nowait = true, remap = false },
    { "<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>",
        desc = "Find Text", nowait = true, remap = false },
    { "<leader>f",
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        desc = "Find files", nowait = true, remap = false },
    { "<leader>h", "<cmd>nohlsearch<CR>",
        desc = "No Highlight", nowait = true, remap = false },
    { "<leader>P", "<cmd>Telescope projects<cr>",
        desc = "Projects", nowait = true, remap = false },
    { "<leader>q", "<cmd>q!<CR>",
        desc = "Quit", nowait = true, remap = false },
    { "<leader>u", "<cmd>UndotreeToggle<cr>",
        desc = "Undo Tree", nowait = true, remap = false },
    { "<leader>w", "<cmd>w!<CR>",
        desc = "Save", nowait = true, remap = false },
    { "<leader>x", "<cmd>source ~/.config/nvim/init.lua<cr>",
        desc = "Reload Neovim Config", nowait = true, remap = false },

    { "<leader>c", group = "Compile", nowait = true, remap = false },
        { "<leader>cc", group = "CMake", nowait = true, remap = false },
            { "<leader>ccc", "<cmd>Task start cmake configure<cr>",
                desc = "Configure Cmake", nowait = true, remap = false },
            { "<leader>ccd", "<cmd>Task start cmake debug<cr>",
                desc = "Debug", nowait = true, remap = false },
            { "<leader>ccr", "<C-w>l:copen 4<Bar> Task start cmake run<cr>",
                desc = "Run Cmake", nowait = true, remap = false },
            { "<leader>ccs", "<cmd>Task set_module_param cmake target<cr>",
                desc = "Set CMake Target", nowait = true, remap = false },
            { "<leader>ccx", "<C-w>l<C-w>j:q<cr>",
                desc = "Close Quickfix Window", nowait = true, remap = false },
        { "<leader>cm", group = "Make", nowait = true, remap = false },
            { "<leader>cmA", "<cmd>TermExec cmd='./RunAOC.sh build'<cr>",
                desc = "Build Advent of Code", nowait = true, remap = false },
            { "<leader>cma", group = "Advent of Code", nowait = true, remap = false},
                { "<leader>cmaa", "<cmd>TermExec cmd='./RunAOC.sh run'<cr>",
                    desc = "Run Advent of Code", nowait = true, remap = false },
                { "<leader>cmat", "<cmd>TermExec cmd='./RunAOC.sh runWithTest'<cr>",
                    desc = "Run Advent of Code With Test Input", nowait = true, remap = false },
            { "<leader>cmb", "<cmd>TermExec cmd='make build'<cr>",
                desc = "Make build", nowait = true, remap = false },
            { "<leader>cmc", "<cmd>Task start make clean<cr>",
                desc = "Make clean", nowait = true, remap = false },
            { "<leader>cmr", "<cmd>TermExec cmd='make run'<cr>",
                desc = "Make run", nowait = true, remap = false },
            { "<leader>cmt", "<cmd>TermExec cmd='make -s runTest'<cr>",
                desc = "Make Run Test", nowait = true, remap = false },
            { "<leader>cmx", "<C-w>l<C-w>j:q<cr>",
                desc = "Close Quickfix Window", nowait = true, remap = false },
        { "<leader>cx", "<C-w>l<C-w>j:q<cr>",
                desc = "Close Quickfix Window", nowait = true, remap = false },

    { "<leader>d", group = "Debug", nowait = true, remap = false },
        { "<leader>dB", "<cmd>lua require'dap'.clear_breakpoints()<cr>",
            desc = "Clear All Breakpoints", nowait = true, remap = false },
        { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>",
            desc = "Step Out (F9)", nowait = true, remap = false },
        { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
            desc = "Breakpoint", nowait = true, remap = false },
        { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",
            desc = "Continue (F5)", nowait = true, remap = false },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",
            desc = "Step Into (F7)", nowait = true, remap = false },
        { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>",
            desc = "Run last", nowait = true, remap = false },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",
            desc = "Step Over (F8)", nowait = true, remap = false },
        { "<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>",
            desc = "Repl", nowait = true, remap = false },
        { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>",
            desc = "UI", nowait = true, remap = false },
        { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>",
            desc = "Terminate", nowait = true, remap = false },

    { "<leader>g", group = "Git", nowait = true, remap = false },
        { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
            desc = "Reset Buffer", nowait = true, remap = false },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>",
            desc = "Checkout branch", nowait = true, remap = false },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>",
            desc = "Checkout commit", nowait = true, remap = false },
        { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",
            desc = "Diff", nowait = true, remap = false },
        { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
            desc = "Lazygit", nowait = true, remap = false },
        { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
            desc = "Next Hunk", nowait = true, remap = false },
        { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
            desc = "Prev Hunk", nowait = true, remap = false },
        { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",
            desc = "Blame", nowait = true, remap = false },
        { "<leader>go", "<cmd>Telescope git_status<cr>",
            desc = "Open changed file", nowait = true, remap = false },
        { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
            desc = "Preview Hunk", nowait = true, remap = false },
        { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
            desc = "Reset Hunk", nowait = true, remap = false },
        { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
            desc = "Stage Hunk", nowait = true, remap = false },
        { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            desc = "Undo Stage Hunk", nowait = true, remap = false },

    { "<leader>m", group = "Markdown preview", nowait = true, remap = false },
        { "<leader>mp", "<cmd>MarkdownPreview<cr>",
            desc = "Start Preview", nowait = true, remap = false },
        { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>",
            desc = "Stop Preview", nowait = true, remap = false },

    { "<leader>s", group = "Search", nowait = true, remap = false },
        { "<leader>sC", "<cmd>Telescope commands<cr>",
            desc = "Commands", nowait = true, remap = false },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>",
            desc = "Man Pages", nowait = true, remap = false },
        { "<leader>sR", "<cmd>Telescope registers<cr>",
            desc = "Registers", nowait = true, remap = false },
        { "<leader>sb", "<cmd>Telescope git_branches<cr>",
            desc = "Checkout branch", nowait = true, remap = false },
        { "<leader>sc", "<cmd>Telescope colorscheme<cr>",
            desc = "Colorscheme", nowait = true, remap = false },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>",
            desc = "Find Help", nowait = true, remap = false },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>",
            desc = "Keymaps", nowait = true, remap = false },
        { "<leader>sr", "<cmd>Telescope oldfiles<cr>",
            desc = "Open Recent File", nowait = true, remap = false },

    { "<leader>t", group = "Template", nowait = true, remap = false },
        { "<leader>tc", group = "C", nowait = true, remap = false },
            { "<leader>tca", "<cmd>TemplateInit c/cAdvent<cr>",
                desc = "C Advent of Code", nowait = true, remap = false },
            { "<leader>tch", "<cmd>TemplateInit c/cHeader<cr>",
                desc = "C Header", nowait = true, remap = false },
            { "<leader>tcl", "<cmd>TemplateInit c/cLib<cr>",
                desc = "C Library", nowait = true, remap = false },
            { "<leader>tcm", "<cmd>TemplateInit c/cMain<cr>",
                desc = "C Main", nowait = true, remap = false },
        { "<leader>tj", group = "Java", nowait = true, remap = false },
            { "<leader>tjc", "<cmd>TemplateInit java/javaClass<cr>",
                desc = "Java Class", nowait = true, remap = false },
            { "<leader>tjm", "<cmd>TemplateInit java/javaMain<cr>",
                desc = "Java Main Class", nowait = true, remap = false },
        { "<leader>tp", group = "C++", nowait = true, remap = false },
            { "<leader>tpa", "<cmd>TemplateInit cpp/cppAOC<cr>",
                desc = "C++ Advent Of Code", nowait = true, remap = false },
            { "<leader>tpm", "<cmd>TemplateInit cpp/cppMain<cr>",
                desc = "C++ Main", nowait = true, remap = false },
})

-- Add to existing leaders
which_key.add({
    { "gb", desc = "Block Comment" },
    { "gc", desc = "Comment" },
    { "gg", desc = "Go To Top Of File" },
    { "gh", desc = "First char of line" },
    { "gl", desc = "End of line" },
    {
        mode = { "v" },
        { "gb", desc = "Block Comment" },
        { "gc", desc = "Comment" },
        { "gg", desc = "Go To Top Of File" },
        { "gh", desc = "First char of line" },
        { "gl", desc = "End of line" },
    },
})

