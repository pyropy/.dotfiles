-- Tabs. May be overridden by autocmd rules
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- live preview of :s///

vim.opt.fileformats = "unix,dos,mac"

-- Visual settings
vim.opt.number = true -- without this the cursor line shows 0
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes" -- stop text shifting when diagnostics appear
vim.opt.scrolloff = 3
vim.opt.winborder = "rounded" -- applies to hover and all floats

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.mousemodel = "popup"

-- Persistent undo. undotree is close to useless without this: history
-- otherwise dies when the buffer unloads.
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.updatetime = 250 -- default 4000
vim.opt.confirm = true   -- prompt instead of failing on unsaved :q

-- Use modeline overrides
vim.opt.modeline = true
vim.opt.modelines = 10

vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"

-- Copy/Paste/Cut
-- has() returns a number and 0 is truthy in Lua, so this needs an explicit
-- comparison or the guard always passes.
if vim.fn.has('unnamedplus') == 1 then
    vim.opt.clipboard = "unnamed,unnamedplus"
end

-- Stop indentLine hiding JSON strings. Setting conceallevel=0 here does not
-- work: indentLine assigns &l:conceallevel=2 buffer-locally from its own
-- after/plugin file, which beats a global. indentLine_setConceal=0 makes it
-- skip touching conceal at all. Both lines go away with indentLine itself.
vim.g.indentLine_setConceal = 0
vim.opt.conceallevel = 0
