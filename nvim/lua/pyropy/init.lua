require("pyropy.set")
require("pyropy.remap")

function R(name)
    require("plenary.reload").reload_module(name)
end

local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local clear_au = vim.api.nvim_clear_autocmds

-- Autoformat on save
local augroup = ag("LspFormatting", { clear = false })
au("BufWritePre", {
    clear_au({ group = augroup, buffer = bufnr }),
    group = augroup,
    buffer = bufnr,
    callback = function()
        vim.lsp.buf.format()
    end,
})
