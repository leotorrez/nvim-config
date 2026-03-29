-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "v" }, "/", "y/<C-r>0", { desc = "Search selection" })
-- Keybind to trigger BlenderManage
vim.keymap.set("n", "<leader>Bl", ":BlenderLaunch<CR>", { desc = "Launch Blender" })
vim.keymap.set("n", "<leader>Bm", ":BlenderManage<CR>", { desc = "Open Blender Manage" })
vim.keymap.set("n", "<leader>Bo", ":BlenderOutput<CR>", { desc = "Open Blender Output" })
vim.keymap.set("n", "<leader>Br", ":BlenderReload<CR>", { desc = "Reload Blender Add-on" })
