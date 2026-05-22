return {
    { "folke/flash.nvim", enabled = false },
    { "twio142/vim-visual-multi" },
    {
        "hrsh7th/nvim-cmp",
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
                        cmp.select_next_item()
                    elseif vim.snippet.active({ direction = 1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(1)
                        end)
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.snippet.active({ direction = -1 }) then
                        vim.schedule(function()
                            vim.snippet.jump(-1)
                        end)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
        end,
    },
    {
        "folke/which-key.nvim",
        opts = {
            delay = 0, -- Makes the UI react instantly to your first <leader> press
        },
        ---@type LazySpec
        {
            "mikavilpas/yazi.nvim",
            version = "*", -- use the latest stable version
            event = "VeryLazy",
            dependencies = {
                { "nvim-lua/plenary.nvim", lazy = true },
            },
            keys = {
                {
                    "<leader>-",
                    mode = { "n", "v" },
                    "<cmd>Yazi<cr>",
                    desc = "Open yazi at the current file",
                },
                {
                    "<leader>cw",
                    "<cmd>Yazi cwd<cr>",
                    desc = "Open the file manager in nvim's working directory",
                },
                {
                    "<c-up>",
                    "<cmd>Yazi toggle<cr>",
                    desc = "Resume the last yazi session",
                },
            },
            ---@type YaziConfig | {}
            opts = {
                open_for_directories = false,
                keymaps = {
                    show_help = "<f1>",
                },
            },
            -- 👇 if you use `open_for_directories=true`, this is recommended
            init = function()
                -- mark netrw as loaded so it's not loaded at all.
                --
                -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
                vim.g.loaded_netrwPlugin = 1
            end,
        },
    },
}
