local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local on_attach = function(_, _)
        vim.diagnostic.config({ virtual_lines = false })
        require("which-key").add({
                { "<leader>l", group = "LSP", nowait = true },
                { "<leader>lI", "<cmd>LspInstallInfo<cr>",
			desc = "Installer Info", nowait = true },
                { "<leader>lR", "<cmd>LspRestart<cr>",
			desc = "Restart LSP", nowait = true },
                { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			desc = "Workspace Symbols", nowait = true },
                { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",
			desc = "Code Action", nowait = true },
                { "<leader>ld", "<cmd>Telescope lsp_document_diagnostics<cr>",
			desc = "Document Diagnostics", nowait = true },
                { "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>",
			desc = "Format", nowait = true },
                { "<leader>lh", "<cmd>lua vim.lsp.buf.hover<cr>",
			desc = "Show Documentation", nowait = true },
                { "<leader>li", "<cmd>LspInfo<cr>",
			desc = "Info", nowait = true },
                { "<leader>lj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			desc = "Next Diagnostic", nowait = true },
                { "<leader>lk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			desc = "Prev Diagnostic", nowait = true },
                { "<leader>ll", "<cmd>lua require'lsp_lines'.toggle()<cr>",
			desc = "Lsp Lines Toggle", nowait = true },
                { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
			desc = "Quickfix", nowait = true },
                { "<leader>lr", "<cmd>vim.lsp.buf.rename<cr>",
			desc = "Rename", nowait = true },
                { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",
			desc = "Document Symbols", nowait = true },
                { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics", nowait = true },
                { "<leader>lx", "<cmd>LspStop<cr>",
			desc = "Stop LSP", nowait = true },
                { "<leader>lg", group = "Go To", nowait = true },
                        { "<leader>lgD", "<cmd>lua vim.lsp.buf.definition()<CR>",
                                desc = "Go To Definition", nowait = true },
                        { "<leader>lgd", "<cmd>lua vim.lsp.buf.declaration()<CR>",
                                desc = "Go To Declaration", nowait = true },
                        { "<leader>lgi", "<cmd>lua vim.lsp.buf.implementation()<CR>",
                                desc = "Go To implementation", nowait = true },
                        { "<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>",
                                desc = "Go To References", nowait = true },
        })
end

require("lsp_lines").setup()

local capabilities = cmp_nvim_lsp.default_capabilities()

local signs = {
        Error = " ",
        Warn = " ",
        Hint = "󰠠 ",
        Info = " "
}
for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["clangd"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        single_file_support = true,
})

lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
})

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
                                        vim.env.VIMRUNTIME,
                                        "${3rd}/luv/library"
                                        -- "${3rd}/busted/library",
                                },
                        },
                },
        },
})
