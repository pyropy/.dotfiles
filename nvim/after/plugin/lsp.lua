-- LSP, on the core vim.lsp API.
--
-- This replaces lsp-zero v1.x, which called vim.lsp.with() -- removed in
-- Neovim 0.12 -- and so no longer registered any server. Per-server defaults
-- come from nvim-lspconfig's lsp/*.lua files, which vim.lsp.config and
-- vim.lsp.enable read off the runtimepath; overrides live in nvim/lsp/.

vim.lsp.enable({
    "clangd",
    "gopls",
    "html",
    "lua_ls",
    "rust_analyzer",
    "solc", -- Solidity
    "ts_ls",
})

vim.diagnostic.config({
    virtual_text = { prefix = "▪", spacing = 2 },
    virtual_lines = { current_line = true },
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN]  = "W",
            [vim.diagnostic.severity.HINT]  = "H",
            [vim.diagnostic.severity.INFO]  = "I",
        },
    },
})

-- Buffer-local keymaps. Neovim >= 0.11 already provides grn (rename), gra
-- (code action), grr (references), gri (implementation), gO (document symbol),
-- <C-S> (signature help), K (hover) and ]d/[d unconditionally; the leader
-- mappings below are kept because they are the ones in muscle memory here.
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local opts = { buffer = ev.buf, remap = false }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end,
})
