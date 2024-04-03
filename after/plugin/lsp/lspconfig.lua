local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local on_attach = function(_, _)
    require("which-key").register({
        l = {
            name = "LSP",
            a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
            w = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
            h = {"<cmd>lua vim.lsp.buf.hover<cr>", "Show Documentation" },
            f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
            i = {"<cmd>LspInfo<cr>", "Info" },
            I = {"<cmd>LspInstallInfo<cr>", "Installer Info" },
            j = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic"},
            k = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic"},
            l = {"<cmd>lua require'lsp_lines'.toggle()<cr>", "Lsp Lines Toggle" },
            q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
            r = {"<cmd>vim.lsp.buf.rename<cr>", "Rename" },
            R = {"<cmd>LspRestart<cr>", "Restart LSP" },
            s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
            x = {"<cmd>LspStop<cr>", "Stop LSP"},
            g = {
                name = "Go To",
                d = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Go To Declaration"},
                D = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition"},
                i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Go To implementation"},
                r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Go To References"}
            },
        },
    }, {prefix = "<leader>", nowait = true})
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
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})
