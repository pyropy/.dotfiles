-- Plugin management. Replaces packer.nvim, which has been unmaintained since
-- Aug 2023.
--
-- Note: every spec here is deliberately eager (`lazy = false`, set via
-- `defaults` below). Plugin configuration still lives in after/plugin/*.lua,
-- which Neovim sources at startup -- before any lazy-loaded plugin would be on
-- the runtimepath. Introducing `event`/`cmd`/`keys` on a plugin therefore
-- requires moving its config out of after/plugin and into this spec first.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { "folke/tokyonight.nvim", priority = 1000 }, -- colorscheme set in after/plugin/colors.lua

        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
        },

        "tpope/vim-commentary",  -- Comment stuff out
        "tpope/vim-fugitive",    -- Git wrapper
        "tpope/vim-rhubarb",     -- required by fugitive for :GBrowse
        "airblade/vim-gitgutter",
        "Raimondi/delimitMate",  -- Automatic closing of brackets
        "Yggdroot/indentLine",
        "junegunn/gv.vim",       -- Commit browser
        "mbbill/undotree",
        "tpope/vim-dispatch",

        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            },
        },
        "nvim-telescope/telescope-project.nvim",

        { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate" },
        "nvim-treesitter/playground",

        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v1.x",
            dependencies = {
                -- LSP support
                "neovim/nvim-lspconfig",
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",

                -- Autocompletion
                "hrsh7th/nvim-cmp",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",

                -- Snippets
                "L3MON4D3/LuaSnip",
                "rafamadriz/friendly-snippets",
            },
        },

        -- Debugger
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        },
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",

        -- Terminal
        { "akinsho/toggleterm.nvim", version = "*" },
    },
    defaults = { lazy = false },
    install = { colorscheme = { "tokyonight-night", "habamax" } },
    checker = { enabled = false },
    change_detection = { notify = false },
})
