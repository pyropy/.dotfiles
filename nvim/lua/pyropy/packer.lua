-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use({
        'folke/tokyonight.nvim',
        config = function()
            -- require("lucius").setup()
            vim.cmd('colorscheme tokyonight-night')
        end
    })

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use 'tpope/vim-commentary'   -- Comment stuff ou
    use 'tpope/vim-fugitive'     -- Git wrapper
    use 'airblade/vim-gitgutter' -- Vim git diff tool
    use 'Raimondi/delimitMate'   -- Atomatic closing of brackets and whatnote
    use 'Yggdroot/indentLine'
    use 'tpope/vim-rhubarb'      -- required by fugitive to :Gbrowse
    use 'junegunn/gv.vim'        -- Commit browser
    use 'mbbill/undotree'        -- Undo stuff
    use 'tpope/vim-dispatch'
    use 'github/copilot.vim'     -- Github copilot

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'nvim-telescope/telescope-project.nvim'
    -- Neovim Tree shitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    -- Debugger
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    use 'theHamsta/nvim-dap-virtual-text'
    use 'leoluz/nvim-dap-go'

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }
end)
