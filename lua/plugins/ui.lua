return {
    {
        "Mofiqul/vscode.nvim",
        config = function()
            local c = require("vscode.colors").get_colors()
            require("vscode").setup({
                transparent = true,
                underline_links = true,
                disable_nvimtree_bg = true,
                terminal_colors = true,
                group_overrides = {
                    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                },
            })
            -- load the theme without affecting devicon colors.
            vim.cmd.colorscheme("vscode")
        end,
    },
    {
        "bufferline.nvim",
        config = function()
            require("bufferline").setup({
                options = {
                    close_command = "bdelete %d",
                    indicator = {
                        style = "icon",
                        icon = " ",
                    },
                    left_trunc_marker = "",
                    modified_icon = "●",
                    offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
                    right_mouse_command = "bdelete! %d",
                    right_trunc_marker = "",
                    show_close_icon = false,
                    show_tab_indicators = true,
                },
                highlights = {
                    fill = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "StatusLineNC" },
                    },
                    background = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "StatusLine" },
                    },
                    buffer_visible = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                    buffer_selected = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                    separator = {
                        fg = { attribute = "bg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "StatusLine" },
                    },
                    separator_selected = {
                        fg = { attribute = "fg", highlight = "Special" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                    separator_visible = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "StatusLineNC" },
                    },
                    close_button = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "StatusLine" },
                    },
                    close_button_selected = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                    close_button_visible = {
                        fg = { attribute = "fg", highlight = "Normal" },
                        bg = { attribute = "bg", highlight = "Normal" },
                    },
                },
            })
        end,
    },
    {
        "snacks.nvim",
        opts = {
            scroll = { enabled = false },
            zen = {
                toggles = { dim = false },
            },
            dashboard = {
                preset = {
                    header = [[
██╗     ███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
██║     ██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██║     █████╗  ██║♌ ██║██║   ██║██║██╔████╔██║
██║     ██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                            ]],
                    -- stylua: ignore start
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        { icon = " ", key = "S", desc = "Select Session", action = "<leader>qS" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')"},
                        -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "t", desc = "Todo", action = ":TodoTelescope" },
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')"},
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')"},
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                        { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"},
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    -- stylua: ignore end
                },
                sections = {
                    { section = "header" },
                    { section = "keys", padding = 1, gap = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { section = "startup" },
                },
            },
        },
    },
}
