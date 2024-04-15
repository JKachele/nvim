local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

-- Install your plugins here
lazy.setup({
    -- My plugins here
    "nvim-lua/popup.nvim",                      -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim",                    -- Useful lua functions used ny lots of plugins
    "windwp/nvim-autopairs",                    -- Autopairs, integrates with both cmp and treesitter
    "numToStr/Comment.nvim",                    -- Easily comment stuff
    "nvim-lualine/lualine.nvim",                -- Status Line on bottom
    "akinsho/bufferline.nvim",                  -- Line to show open Buffers
    "moll/vim-bbye",                            -- Easily delete buffers
    "akinsho/toggleterm.nvim",                  -- Floating Terminal in Nvim
    "ahmedkhalf/project.nvim",                  -- Easy Project management
    "goolord/alpha-nvim",                       -- Neovim Title Screen
    "Shatur/neovim-tasks",                      -- Create tasks to easily compile and run projects
    "folke/which-key.nvim",                     -- Easily see keybinds
    { "jkachele/vim-templates",                 -- Add templates for files

        branch = "all"
    },
    { "nvim-tree/nvim-tree.lua",                -- Side Panel File Navigation
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    { "lukas-reineke/indent-blankline.nvim",    -- Creates an indent line
        main = "ibl",
        opts = {}
    },
    { "m4xshen/hardtime.nvim",                  -- Disable some keybinds to force use of vim binds
        dependencies = { "MunifTanjim/nui.nvim" }
    },
    { "iamcco/markdown-preview.nvim",           -- Preview Markdown files in the browser
        build=function()
            vim.fn["mkdp#util#install"]()
        end
    },
    { "stevearc/dressing.nvim",                 -- Enable floating input and selection panels
        event = "VeryLazy",
    },
    { "kevinhwang91/nvim-ufo",                  -- Customize folding
        dependencies = { "kevinhwang91/promise-async" }
    },

    -- Colorschemes
    { "bluz71/vim-moonfly-colors",              -- Moonfly Colorscheme
        name = "moonfly"
    },

    -- cmp plugins
    { "hrsh7th/nvim-cmp", commit = "1cad30f" }, -- The completion plugin
    "hrsh7th/cmp-buffer",                       -- buffer completions
    "hrsh7th/cmp-path",                         -- path completions
    "hrsh7th/cmp-cmdline",                      -- cmdline completions
    "saadparwaiz1/cmp_luasnip",                 -- snippet completions
    "hrsh7th/cmp-nvim-lua",                     -- Completions for nvim lua API
    "hrsh7th/cmp-nvim-lsp",                     -- Completions from lsp
    "L3MON4D3/LuaSnip",                         --snippet engine
    "rafamadriz/friendly-snippets",             -- a bunch of snippets to use
    -- { "tzachar/cmp-tabnine",                    -- Tabnine completions
    --     build="./install.sh"
    -- },

    -- LSP
    "williamboman/mason.nvim",                  -- LSP package manager
    "williamboman/mason-lspconfig.nvim",        -- Bridges mason.nvim with lspconfig
    { "neovim/nvim-lspconfig",                  -- Neovim native LSP client cofiguration
        event = { "BufReadPre", "BufNewFile" },
    },
    "mfussenegger/nvim-jdtls",                  -- Java Language Server
    "ErichDonGubler/lsp_lines.nvim",            -- Inline LSP Diagnostics
    "arkav/lualine-lsp-progress",               -- Shows LSP loading in Lualine

    -- Telescope
    "nvim-telescope/telescope.nvim",            -- Fuzzy Finder and previewer
    "nvim-telescope/telescope-media-files.nvim",-- Enable Media previews

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter",        -- Better syntax highlighting
        build = ":TSUpdate",
    },
    "nvim-treesitter/playground",               -- Easily configure treesitter

    -- Git
    { "lewis6991/gitsigns.nvim",                -- Show Git status and changes
        commit = "fb9fd53"
    },

    -- Debug Adapter Protocol
    "mfussenegger/nvim-dap",                    -- Enable debugging
    { "rcarriga/nvim-dap-ui",                   -- UI for debugging information
        dependencies = { "nvim-neotest/nvim-nio" },
    },
    "nvim-telescope/telescope-dap.nvim",        -- Integrates telescope into dap
    "theHamsta/nvim-dap-virtual-text",          -- adds virtual text in debugging to show variable values
    "jay-babu/mason-nvim-dap.nvim",             -- Adds mason functionality to dap
    "mfussenegger/nvim-dap-python",             -- python debugging
})
