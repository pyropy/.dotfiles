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

        -- LSP. Servers are configured with the core vim.lsp.config/vim.lsp.enable
        -- API in after/plugin/lsp.lua; nvim-lspconfig is here only to supply the
        -- per-server lsp/*.lua definitions those APIs read off the runtimepath.
        "neovim/nvim-lspconfig",
        { "mason-org/mason.nvim", opts = {} },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                -- Installs the server binaries. Enabling them is done
                -- explicitly in after/plugin/lsp.lua, not here.
                automatic_enable = false,
                ensure_installed = {
                    "clangd",
                    "gopls",
                    "html",
                    "lua_ls",
                    "rust_analyzer",
                    "ts_ls", -- renamed from tsserver in Sept 2024
                },
            },
        },

        -- Lua development: replaces hand-maintained `globals = { 'vim' }` lists
        { "folke/lazydev.nvim", ft = "lua", opts = {} },

        -- Completion
        {
            "saghen/blink.cmp",
            version = "1.*", -- release tag: ships a prebuilt fuzzy matcher
            opts = {
                keymap = {
                    -- Tab/S-Tab keep selecting completion items, as under
                    -- nvim-cmp. `fallback` means that when the menu is closed
                    -- they defer to Neovim's own <Tab> snippet-jump mapping
                    -- rather than shadowing it.
                    preset = "none",
                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<CR>"] = { "accept", "fallback" },
                    ["<C-space>"] = { "show", "hide" },
                    ["<C-e>"] = { "hide", "fallback" },
                },
                sources = { default = { "lsp", "path", "snippets", "buffer" } },
                signature = { enabled = true },
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
