-- Colorscheme. Previously set from a packer `config` callback, which lived only in
-- the generated plugin/packer_compiled.lua; moved here so it survives the plugin
-- manager migration.
local ok = pcall(vim.cmd.colorscheme, "tokyonight-night")
if not ok then
    vim.cmd.colorscheme("habamax")
end
