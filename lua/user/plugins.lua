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
    "nvim-lua/popup.nvim",          -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim",        -- Useful lua functions used ny lots of plugins
    "windwp/nvim-autopairs",        -- Autopairs, integrates with both cmp and treesitter
    "numToStr/Comment.nvim",        -- Easily comment stuff
    "nvim-tree/nvim-web-devicons",
    { "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {"nvim-tree/nvim-web-devicons"},
    },
    "akinsho/bufferline.nvim",
    "moll/vim-bbye",
    "nvim-lualine/lualine.nvim",
    "arkav/lualine-lsp-progress",
    "akinsho/toggleterm.nvim",
    "ahmedkhalf/project.nvim",
    "lewis6991/impatient.nvim",
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    "goolord/alpha-nvim",
    "Shatur/neovim-tasks",
    -- "eandrju/cellular-automaton.nvim",
    "jkachele/vim-templates-java",
    "folke/which-key.nvim",
    { "m4xshen/hardtime.nvim", dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" } },
    { "iamcco/markdown-preview.nvim", build=function() vim.fn["mkdp#util#install"]() end },

    -- Colorschemes
    -- "lunarvim/colorschemes", -- A bunch of colorschemes you can try out
    { "bluz71/vim-moonfly-colors", name = "moonfly" },

    -- CSV Highlighting
    {
        'cameron-wags/rainbow_csv.nvim',
        config = true,
        ft = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        cmd = {
            'RainbowDelim',
            'RainbowDelimSimple',
            'RainbowDelimQuoted',
            'RainbowMultiDelim'
        }
    },

    -- Vim Game
    "ThePrimeagen/vim-be-good",

    -- cmp plugins
    {"hrsh7th/nvim-cmp", commit = "1cad30f"}, -- The completion plugin
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    {"tzachar/cmp-tabnine", build="./install.sh"}, -- Tabnine completions
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",

    -- snippets
    "L3MON4D3/LuaSnip", --snippet engine
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- LSP
    "neovim/nvim-lspconfig", -- enable LSP
    {"williamboman/mason.nvim",
    build = ":MasonUpdate"},
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    },
    "mfussenegger/nvim-jdtls",
    "simrat39/rust-tools.nvim",

    -- Telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    -- "p00f/nvim-ts-rainbow",
    -- "nvim-treesitter/playground",
    -- "JoosepAlviste/nvim-ts-context-commentstring",

    -- Git
    "lewis6991/gitsigns.nvim",

    -- Debug Adapter Protocol
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope-dap.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",-- Automatically set up your configuration after cloning packer.nvim
    "mfussenegger/nvim-dap-python",
})
