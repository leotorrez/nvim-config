local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
-- Integrates mcphub with CopilotChat, dynamically registering tools and resources as CopilotChat functions.
-- Listens for mcphub events to update available tools/resources in CopilotChat.
local chat = require("CopilotChat")
local mcp = require("mcphub")

-- Initialize mcphub plugin.
mcp.setup()

-- Register event handler for mcphub updates.
mcp.on({ "servers_updated", "tool_list_changed", "resource_list_changed" }, function()
    local hub = mcp.get_hub_instance()
    if not hub then
        return
    end

    -- Import plenary async utilities.
    local async = require("plenary.async")

    -- Wraps hub:call_tool in an async function for CopilotChat tool invocation.
    -- @param server string: Server name
    -- @param tool string: Tool name
    -- @param input table: Tool input
    -- @param callback function: Callback to receive result and error
    local call_tool = async.wrap(function(server, tool, input, callback)
        hub:call_tool(server, tool, input, {
            callback = function(res, err)
                callback(res, err)
            end,
        })
    end, 4)

    -- Wraps hub:access_resource in an async function for CopilotChat resource access.
    -- @param server string: Server name
    -- @param uri string: Resource URI
    -- @param callback function: Callback to receive result and error
    local access_resource = async.wrap(function(server, uri, callback)
        hub:access_resource(server, uri, {
            callback = function(res, err)
                callback(res, err)
            end,
        })
    end, 3)

    -- Register resources as CopilotChat functions.
    local resources = hub:get_resources()
    for _, resource in ipairs(resources) do
        local name = resource.name:lower():gsub(" ", "_"):gsub(":", "")
        if not chat.config.functions then
            chat.config.functions = {}
        end
        chat.config.functions[name] = {
            uri = resource.uri,
            description = type(resource.description) == "string" and resource.description or "",
            -- Resolves the resource and returns its content for CopilotChat.
            resolve = function()
                local res, err = access_resource(resource.server_name, resource.uri)
                if err then
                    error(err)
                end

                res = res or {}
                local result = res.result or {}
                local content = result.contents or {}
                local out = {}

                for _, message in ipairs(content) do
                    if message.text then
                        table.insert(out, {
                            uri = message.uri,
                            data = message.text,
                            mimetype = message.mimeType,
                        })
                    end
                end

                return out
            end,
        }
    end

    -- Register tools as CopilotChat functions.
    local tools = hub:get_tools()
    for _, tool in ipairs(tools) do
        chat.config.functions[tool.name] = {
            group = tool.server_name,
            description = tool.description,
            schema = tool.inputSchema,
            -- Resolves the tool invocation and returns its output for CopilotChat.
            -- @param input table: Tool input
            resolve = function(input)
                local res, err = call_tool(tool.server_name, tool.name, input)
                if err then
                    error(err)
                end

                res = res or {}
                local result = res.result or {}
                local content = result.content or {}
                local out = {}

                for _, message in ipairs(content) do
                    if message.type == "text" then
                        table.insert(out, {
                            data = message.text,
                        })
                    elseif message.type == "resource" and message.resource and message.resource.text then
                        table.insert(out, {
                            uri = message.resource.uri,
                            data = message.resource.text,
                            mimetype = message.resource.mimeType,
                        })
                    end
                end

                return out
            end,
        }
    end
end)
