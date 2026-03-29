-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
if windows then
    vim.o.shell = [["pwsh.exe"]]
end
vim.opt.title = true
vim.opt.titlestring = [[%t – %{fnamemodify(getcwd(), ':t')}]]
vim.o.winborder = "rounded"
vim.g.ai_cmp = false
