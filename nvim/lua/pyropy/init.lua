require("pyropy.set")
require("pyropy.remap") -- must precede lazy: it sets mapleader, which lazy
                        -- captures when it resolves `keys` specs
require("pyropy.lazy")

function R(name)
    require("plenary.reload").reload_module(name)
end

local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

-- Format on save, but only for buffers with a client that can actually format.
-- Previously this registered a single global BufWritePre autocmd (the `bufnr`
-- it referenced was a nil global), so writing any buffer without an attached
-- LSP printed "Format request failed, no matching language servers".
local augroup = ag("LspFormatting", { clear = true })

au("LspAttach", {
    group = augroup,
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client or not client:supports_method("textDocument/formatting") then
            return
        end

        au("BufWritePre", {
            group = augroup,
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id })
            end,
        })
    end,
})
