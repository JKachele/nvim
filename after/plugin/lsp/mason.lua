local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
        ui = {
                border = "none",
                icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                },
        }
})

mason_lspconfig.setup({
        ensure_installed = {
                "lua_ls",
                -- "pyright",
                -- "jsonls",
                "clangd",
                "cmake",
                -- "asm_lsp",
                -- "cmake",
                "arduino_language_server",
                "jdtls",
                "rust_analyzer",
        },
        automatic_installation = true,
})
