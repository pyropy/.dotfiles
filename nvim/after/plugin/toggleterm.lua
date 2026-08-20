local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

toggleterm.setup {
    size = 20,
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = false,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
}

-- Scope the <Esc> override to toggleterm's own terminals. Mapping it globally
-- also hijacked plain :terminal buffers (e.g. the ones <leader>sh opens), where
-- Esc would fire toggleterm's toggle instead of leaving terminal mode.
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function(ev)
        vim.keymap.set("t", "<esc>", [[<C-t><C-n>]], { buffer = ev.buf, silent = true })
    end,
})
