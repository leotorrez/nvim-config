return {
    {
        -- "b0o/blender.nvim",
        dir = "D:/Githubrepos/blender.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "grapp-dev/nui-components.nvim" },
        opts = {
            -- notify={level="DEBUG"},
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    },
    {
        "apyra/nvim-unity-sync",
        ft = "cs",
    },
    {
        "stevearc/conform.nvim",
        opts = {
            -- log_level = vim.log.levels.DEBUG,
            formatters_by_ft = {
                dosini = { "iiidmformatter" },
            },
            formatters = {
                iiidmformatter = {
                    command = "D:/Proyectos/Coding/IIIDMFormatter/main.dist/iiidmformatter.exe",
                    -- command = "D:/Proyectos/Coding/IIIDMFormatter/iiidmformatter.exe",
                    stdin = true,
                },
            },
        },
    },
}
