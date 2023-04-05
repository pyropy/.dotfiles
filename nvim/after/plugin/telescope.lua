require('telescope').setup {
    defaults = {
        file_ignore_patterns = { "node%_modules/.*", "vendor/*" }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>e', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
