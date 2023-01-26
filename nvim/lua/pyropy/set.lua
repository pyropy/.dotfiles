-- Encoding
vim.opt.encoding="utf-8"
vim.opt.fileencoding="utf-8"
vim.opt.fileencodings="utf-8"

-- Fix backspace indent
vim.opt.backspace="indent,eol,start"

-- Tabs. May be overridden by autocmd rules
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable hidden buffers
vim.opt.hidden = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true 

vim.opt.fileformats="unix,dos,mac"

-- Visual Settings
vim.opt.ruler = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.mousemodel = "popup"
vim.opt.guioptions = "egmrti"
vim.opt.gfn="Monospace 10"

-- Disable the blinking cursor.
vim.opt.gcr = "a:blinkon0"
vim.opt.scrolloff = 3

-- Status bar
vim.opt.laststatus = 2

-- Use modeline overrides
vim.opt.modeline = true
vim.opt.modelines = 10

vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"

-- Copy/Paste/Cut
if vim.fn.has('unnamedplus') then
  vim.opt.clipboard = "unnamed,unnamedplus"
end

