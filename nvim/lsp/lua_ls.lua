-- Merged over nvim-lspconfig's lsp/lua_ls.lua. lazydev.nvim supplies the
-- workspace library and the `vim` global for config files, so this only
-- carries preferences.
return {
    settings = {
        Lua = {
            hint = { enable = true },
            telemetry = { enable = false },
        },
    },
}
