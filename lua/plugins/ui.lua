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
                    -- buffer_close_icon = "",
                    close_command = "bdelete %d",
                    -- close_icon = "",
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
                    { title = "C12H22O11", align = "right", padding = { 3, 5 }, indent = 4, pane = 2 },
                    { section = "keys", padding = 1, gap = 1 },
                    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        desc = "Browse Repo",
                        padding = 1,
                        key = "b",
                        action = function()
                            Snacks.gitbrowse()
                        end,
                    },
                    function()
                        local in_git = Snacks.git.get_root() ~= nil
                        local cmds = {
                            {
                                title = "Notifications",
                                cmd = "gh notify -s -a -n5",
                                action = function()
                                    vim.ui.open("https://github.com/notifications")
                                end,
                                key = "n",
                                icon = " ",
                                height = 5,
                                enabled = true,
                            },
                            {
                                title = "Open Issues",
                                cmd = "gh issue list -L 3",
                                key = "i",
                                action = function()
                                    vim.fn.jobstart("gh issue list --web", { detach = true })
                                end,
                                icon = " ",
                                height = 7,
                            },
                            {
                                icon = " ",
                                title = "Open PRs",
                                cmd = "gh pr list -L 3",
                                key = "P",
                                action = function()
                                    vim.fn.jobstart("gh pr list --web", { detach = true })
                                end,
                                height = 7,
                            },
                            {
                                icon = " ",
                                title = "Git Status",
                                cmd = "git --no-pager diff --stat -B -M -C",
                                height = 10,
                            },
                        }
                        return vim.tbl_map(function(cmd)
                            return vim.tbl_extend("force", {
                                pane = 2,
                                section = "terminal",
                                enabled = in_git,
                                padding = 1,
                                ttl = 5 * 60,
                                indent = 3,
                            }, cmd)
                        end, cmds)
                    end,
                    { section = "startup" },
                },
            },
        },
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = { -- Default  Range
            stiffness = 0.8, -- 0.6      [0, 1]
            trailing_stiffness = 0.5, -- 0.4      [0, 1]
            stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
            trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
            distance_stop_animating = 0.9, -- 0.1      > 0
        },
    },
}
