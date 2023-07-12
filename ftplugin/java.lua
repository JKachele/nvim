local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name

local config = {
    cmd = {
        '/usr/lib/jvm/java-17-openjdk/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '-jar', '/home/jkachele/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar',
        '-configuration', '/home/jkachele/.local/share/nvim/mason/packages/jdtls/config_linux',
        '-data', workspace_dir,
        --'add-modules=ALL-SYSTEM',
        --'add-opens', 'java.base/java.util=ALL-UNNAMED',
        --'add-opens', 'java.base/java.lang=ALL-UNNAMED',
    },

    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'build.gradle', 'pom.xml'}),


    capabilities = capabilities,

    settings = {
        java = {
            format = {
                enabled = true,
                settings = {
                    url = vim.fn.stdpath "config" .. "/codeStyles/intellij-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            -- project = {
            --     referencedLibraries = {
            --         '~/.gradle/caches/modules-2/files-2.1/org.joml/joml/1.10.5/22566d58af70ad3d72308bab63b8339906deb649/joml-1.10.5.jar',
            --     },
            -- },
        },
    },
}

require('jdtls').start_or_attach(config)

require("which-key").register({
    j = {
        name = "Java",
        o = {"<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports"},
        v = {"<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable"},
        c = {"<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant"},
        m = {"<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method"},
        a = {"<cmd>lua require('jdtls').code_action()<CR>", "Code Action"},
    }
}, {prefix = "<leader>", nowait = true})

