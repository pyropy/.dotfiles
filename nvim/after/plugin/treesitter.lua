require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "vimdoc", "javascript", "typescript", "go", "lua", "rust", "solidity" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Off deliberately: auto_install needs the `tree-sitter` CLI, which is not
    -- installable on this machine (see the note in lua/pyropy/lazy.lua). With
    -- it on, every startup re-kicks failing downloads -- that cost ~390ms.
    -- Add languages to ensure_installed and run :TSUpdate instead.
    auto_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
