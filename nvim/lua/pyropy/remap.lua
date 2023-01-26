vim.g.mapleader = ","

-- terminal emulation
vim.keymap.set("n", "<leader>sh", ":terminal<CR>", { silent = true })

-- Remap ESC to exit terminal mode

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })


-- session management
vim.keymap.set("n", "<leader>so", ":OpenSession<Space>", { noremap = true })
vim.keymap.set("n", "<leader>ss", ":SaveSession<Space>", { noremap = true })
vim.keymap.set("n", "<leader>sd", ":DeleteSession<CR>", { noremap = true })
vim.keymap.set("n", "<leader>sc", ":CloseSession<CR>", { noremap = true })

-- Tabs
vim.keymap.set("n", "<Tab>", "gt", { noremap = true })
vim.keymap.set("n", "<S-Tab>", "gT", { noremap = true })
vim.keymap.set("n", "<S-t>", ":tabnew<CR>", { silent = true, noremap = true })

-- Set working directory
vim.keymap.set("n", "<leader>.", ":lcd %:p:h<CR>", { noremap = true })

-- Opens an edit command with the path of the currently edited file filled in
vim.keymap.set("", "<leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>', { noremap = true })

-- Opens a tab edit command with the path of the currently edited file filled
vim.keymap.set("", "<leader>te", ':tabe <C-R>=expand("%:p:h") . "/" <CR>', { noremap = true })

-- Clean search (highlight)
vim.keymap.set("n", "<leader><space>", ":noh<cr>", { noremap = true, silent = true })

-- Switching windows
vim.keymap.set("", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("", "<C-l>", "<C-w>l", { noremap = true })
vim.keymap.set("", "<C-h>", "<C-w>h", { noremap = true })

-- Vmap for maintain Visual Mode after shifting > and <
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Buffer nav
vim.keymap.set("", "<leader>z", ":bp<CR>", { noremap = true })
vim.keymap.set("", "<leader>q", ":bp<CR>", { noremap = true })
vim.keymap.set("", "<leader>x", ":bn<CR>", { noremap = true })
vim.keymap.set("", "<leader>w", ":bn<CR>", { noremap = true })

-- Close buffer
vim.keymap.set("", "<leader>c", ":bd<CR>", { noremap = true })

if vim.fn.has('macunix') then
    -- pbcopy for OSX copy/paste
    vim.keymap.set("v", "<C-x>", ":!pbcopy<CR>")
    vim.keymap.set("v", "<C-c>", ":w !pbcopy<CR><CR>")
end

vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qall qall
]])
