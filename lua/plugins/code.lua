return {
    {
        "b0o/blender.nvim",
        config = function()
            require("blender").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "grapp-dev/nui-components.nvim",
            "mfussenegger/nvim-dap", -- Optional, for debugging with DAP
            "LiadOz/nvim-dap-repl-highlights", -- Optional, for syntax highlighting in the DAP REPL
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    },
    {
        "you-n-g/jinja-engine.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                pyright = {
                    mason = false,
                    autostart = false,
                },
            },
        },
    },
}
