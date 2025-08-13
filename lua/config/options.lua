-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- vim.g.lazyvim_python_lsp = "ruff"
local windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
if windows then
    vim.o.shell = [["pwsh.exe"]]
    -- vim.o.shellcmdflag = "-NoLogo"
    -- vim.o.shellredir = ">%s 2>&1"
    -- vim.o.shellquote = ""
    -- vim.o.shellxescape = ""
    -- vim.env.TMP = "/tmp"
    -- vim.o.shellxquote = ""
    -- vim.o.shellpipe = "2>&1| tee"
end
