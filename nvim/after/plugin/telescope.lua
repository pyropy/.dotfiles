local telescope = require('telescope')
telescope.load_extension('project')

local project_actions = require("telescope._extensions.project.actions")
telescope.setup {
    defaults = {
        file_ignore_patterns = { "node%_modules/.*", "vendor/*" }
    },
    extensions = {
        project = {
            base_dirs = {
                { path = '~/Development', max_depth = 3 },
            },
            display_type = 'full',
            hidden_files = true, -- default: false
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true, -- default false
        }
    }
}

local builtin = require('telescope.builtin')
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local buffer_searcher
buffer_searcher = function()
    builtin.buffers {
        sort_mru = true,
        attach_mappings = function(prompt_bufnr, map)
            local refresh_buffer_searcher = function()
                actions.close(prompt_bufnr)
                vim.schedule(buffer_searcher)
            end
            local delete_buf = function()
                local selection = action_state.get_selected_entry()
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                refresh_buffer_searcher()
            end
            local delete_multiple_buf = function()
                local picker = action_state.get_current_picker(prompt_bufnr)
                local selection = picker:get_multi_selection()
                for _, entry in ipairs(selection) do
                    vim.api.nvim_buf_delete(entry.bufnr, { force = true })
                end
                refresh_buffer_searcher()
            end
            map('n', 'dd', delete_buf)
            map('n', '<C-d>', delete_multiple_buf)
            map('i', '<C-d>', delete_multiple_buf)
            return true
        end
    }
end

vim.keymap.set('n', '<leader>e', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', buffer_searcher, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set(
    'n',
    '<leader>p',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    { noremap = true, silent = true }
)
