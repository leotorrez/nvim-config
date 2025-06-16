return {
    "b0o/blender.nvim",
    lazy = true,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "grapp-dev/nui-components.nvim",
        "mfussenegger/nvim-dap", -- Optional, for debugging with DAP
        "LiadOz/nvim-dap-repl-highlights", -- Optional, for syntax highlighting in the DAP REPL
    },
    {
        "neolooong/whichpy.nvim",
        opts = {
            uv = { display_name = "uv" },
        },
    },
    {
        "you-n-g/jinja-engine.nvim",
    },
    {
        "conform.nvim",
        opts = {
            formatters_by_ft = {
                ["python"] = { "black" },
            },
        },
    },
}
