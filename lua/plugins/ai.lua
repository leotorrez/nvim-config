return {
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
    -- {
    --     "olimorris/codecompanion.nvim",
    --     config = function()
    --         require("codecompanion").setup({
    --             extensions = {
    --                 mcphub = {
    --                     callback = "mcphub.extensions.codecompanion",
    --                     opts = {
    --                         show_result_in_chat = true, -- Show mcp tool results in chat
    --                         make_vars = true, -- Convert resources to #variables
    --                         make_slash_commands = true, -- Add prompts as /slash commands
    --                     },
    --                 },
    --             },
    --         })
    --     end,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    -- },
    {
        "yetone/avante.nvim",
        build = function()
            -- conditionally use the correct build system for the current OS
            if vim.fn.has("win32") == 1 then
                return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            else
                return "make"
            end
        end,
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            system_prompt = function()
                local hub = require("mcphub").get_hub_instance()
                return hub and hub:get_active_servers_prompt() or ""
            end,
            -- Using function prevents requiring mcphub before it's loaded
            custom_tools = function()
                return {
                    require("mcphub.extensions.avante").mcp_tool(),
                }
            end,
            provider = "copilot",
            providers = {
                ollama = {
                    endpoint = "http://127.0.0.1:11434",
                    model = "Bot:latest",
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "stevearc/dressing.nvim", -- for input provider dressing
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    default = {
                        use_absolute_path = true, -- required for Windows users
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                    },
                },
            },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
