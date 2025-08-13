-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "s", "", { desc = "+Surround" })
vim.keymap.set({ "v" }, "/", "y/<C-r>0", { desc = "Search selection" })
