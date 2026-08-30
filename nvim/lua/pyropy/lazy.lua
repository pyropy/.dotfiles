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

        -- Commenting is built into Neovim >= 0.10 (gc, gcc, visual gc), so
        -- vim-commentary is no longer needed. ts-comments fixes commentstring
        -- for embedded languages (JSX in TS, script tags in HTML).
        { "folke/ts-comments.nvim", opts = {} },

        "tpope/vim-fugitive",    -- Git wrapper
        "tpope/vim-rhubarb",     -- required by fugitive for :GBrowse
        "junegunn/gv.vim",       -- Commit browser
        "mbbill/undotree",
        "tpope/vim-dispatch",

        { "lewis6991/gitsigns.nvim", opts = {} },
        { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            },
        },
        "nvim-telescope/telescope-project.nvim",

        -- Pinned to `master` for now. The `main` branch is a full rewrite and
        -- is the long-term target (master is locked and upstream only
        -- guarantees it for 0.11), but main requires the tree-sitter CLI >=
        -- 0.26.1, which cannot be built here: the prebuilt binary needs glibc
        -- 2.39 (system has 2.35) and building it needs rustc >= 1.88 (default
        -- stable toolchain here is 1.82). Revisit after a rustup update.
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "master",
            lazy = false,
            build = ":TSUpdate",
            -- master registers its predicates/directives with `all = false`,
            -- the pre-0.11 calling convention where a handler got one TSNode
            -- per capture. 0.11 made lists the default and 0.12 dropped the
            -- option outright, so those handlers now get a list where they
            -- expect a node -- e.g. `set-lang-from-info-string!` on a fenced
            -- markdown block calls `node:range()` on a table and every
            -- markdown buffer throws from the highlighter. Restore the old
            -- convention for handlers that ask for it, before master loads.
            init = function()
                if vim.fn.has("nvim-0.12") == 0 then
                    return
                end
                local query = require("vim.treesitter.query")
                local function compat(add)
                    return function(name, handler, opts)
                        if type(opts) == "table" and opts.all == false then
                            local inner = handler
                            handler = function(match, ...)
                                local flat = {}
                                for id, nodes in pairs(match) do
                                    flat[id] = nodes[#nodes]
                                end
                                return inner(flat, ...)
                            end
                        end
                        return add(name, handler, opts)
                    end
                end
                query.add_predicate = compat(query.add_predicate)
                query.add_directive = compat(query.add_directive)
            end,
        },
        -- playground is archived; :InspectTree, :EditQuery and :Inspect replace it.

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
    -- No plugin here needs a rockspec; without this lazy warns about missing
    -- luarocks and tries to bootstrap hererocks.
    rocks = { enabled = false },
})
