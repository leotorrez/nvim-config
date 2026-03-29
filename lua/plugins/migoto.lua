vim.filetype.add({
    extension = {
        ini = "migoto",
    },
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "migoto",
    callback = function()
        vim.bo.commentstring = "; %s"
    end,
})
vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").migoto = {
            tier = 1,
            filetype = "ini",
            install_info = {
                url = "https://github.com/lupomikti/tree-sitter-migoto",
                revision = "main",
                branch = "main",
                queries = "queries/neovim",
                files = { "src/parser.c", "src/scanner.c" },
            },
        }
    end,
})
return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                migoto = { "iiidmformatter" },
            },
            formatters = {
                iiidmformatter = {
                    command = "D:/Proyectos/Coding/IIIDMFormatter/main.dist/iiidmformatter.exe",
                    stdin = true,
                },
            },
        },
    },
}
