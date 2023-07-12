local servers = {
    "lua_ls",
    "pyright",
    "jsonls",
    "clangd",
    "cmake",
    "asm_lsp",
    "cmake",
    "arduino_language_server",
    "jdtls",
    "rust_analyzer",
}

local on_attach = function(_, _)
    require("which-key").register({
        l = {
            name = "LSP",
            a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
            w = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
            f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
            i = {"<cmd>LspInfo<cr>", "Info" },
            I = {"<cmd>LspInstallInfo<cr>", "Installer Info" },
            j = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Next Diagnostic"},
            k = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Prev Diagnostic"},
            l = {"<cmd>lua require'lsp_lines'.toggle()<cr>", "Lsp Lines Toggle" },
            q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
            r = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
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

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig = require("lspconfig")
local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = on_attach,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end

