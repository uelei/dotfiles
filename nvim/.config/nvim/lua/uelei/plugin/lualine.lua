local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local function env_cleanup(venv)
    local final_venv = venv
    if string.find(venv, "/") then
        for w in venv:gmatch("([^/]+)") do
            final_venv = w
        end
    end
    return final_venv
end

local config = {
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = {
            -- { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = {
            "branch",
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " " },
                diagnostics_color = {
                    color_error = { fg = colors.red },
                    color_warn = { fg = colors.yellow },
                    color_info = { fg = colors.cyan },
                },
            },

            {
                "diff",
                -- Is it me or the symbol for modified us really weird
                symbols = { added = " ", modified = "󰝤 ", removed = " " },
                diff_color = {
                    added = { fg = colors.green },
                    modified = { fg = colors.orange },
                    removed = { fg = colors.red },
                },
                cond = conditions.hide_in_width,
            },
        },
        lualine_c = {
            "filename",
            {

                -- env name
                function()
                    if vim.bo.filetype == "python" then
                        local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
                        if venv then
                            local icons = require("nvim-web-devicons")
                            local py_icon, _ = icons.get_icon(".py")
                            return string.format(" " .. py_icon .. " (%s)", env_cleanup(venv))
                        end
                    end
                    return ""
                end,
            },
        },
        lualine_x = {
            {
                -- Lsp server name .
                function()
                    local msg = "No Active Lsp"
                    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                    local clients = vim.lsp.get_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    local lsp_clients = {}
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            table.insert(lsp_clients, client.name)
                        end
                    end
                    local unique_client_names = table.concat(lsp_clients, ", ")
                    local language_servers = string.format("[%s]", unique_client_names)
                    return language_servers
                end,
                icon = " ",
                color = { fg = "#ffffff", gui = "bold" },
            },
            "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}

lualine.setup(config)
