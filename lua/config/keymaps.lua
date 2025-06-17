-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local code_companion = require("codecompanion")
vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "+ai" })
vim.keymap.set({ "n", "v" }, "<leader>ap", code_companion.actions, { desc = "CodeCompanion Actions" })
vim.keymap.set({ "n", "v" }, "<leader>aa", code_companion.toggle, { desc = "CodeCompanion Chat" })
vim.keymap.set({ "n", "v" }, "<leader>aq", function()
    vim.ui.input({
        prompt = "Inline Chat: ",
    }, function(input)
        if input ~= "" then
            code_companion.inline({ args = input })
        end
    end)
end, { desc = "CodeCompanion Inline" })
vim.keymap.set({ "n", "v" }, "<leader>at", function()
    vim.ui.input({
        prompt = "CommandLine AI generation: ",
    }, function(input)
        if input ~= "" then
            code_companion.cmd({ args = input })
        end
    end)
end, { desc = "CodeCompanion CMD" })
