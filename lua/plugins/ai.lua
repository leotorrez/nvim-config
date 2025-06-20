return {
    { "CopilotChat.nvim", enabled = false },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
        config = function()
            require("mcphub").setup()
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        config = function()
            require("codecompanion").setup({
                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            show_result_in_chat = true, -- Show mcp tool results in chat
                            make_vars = true, -- Convert resources to #variables
                            make_slash_commands = true, -- Add prompts as /slash commands
                        },
                    },
                },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
}
