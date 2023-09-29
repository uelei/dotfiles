-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { "j-hui/fidget.nvim",       opts = {},    tag = 'legacy' },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/neodev.nvim",
        },
    },

    {
        "kosayoda/nvim-lightbulb",
        dependencies = "antoinemadec/FixCursorHold.nvim",
    },
    {
        "williamboman/mason.nvim"
    },
    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = {

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind-nvim",
        },
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    -- Useful plugin to show you pending keybinds.
    { "folke/which-key.nvim",          opts = {} },

    -- Git
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },

    {
        "f-person/git-blame.nvim",
        init = function()
            -- vim.g.gitblame_message_template = " <author> - <date> - <summary> - <sha>"
            vim.g.gitblame_enabled = 0
        end,
    },
    "sindrets/diffview.nvim",
    {
        'ruifm/gitlinker.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim', }
    },
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- Theme
    {
        -- Theme inspired by Atom
        "navarasu/onedark.nvim",
        -- config = function()
        --     require('onedark').load()
        -- end,
    },
    {
        "rakr/vim-one"
    },
    {
        "bluz71/vim-nightfly-colors"
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
    },

    {
        -- Set lualine as statusline
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = "onedark",
                component_separators = "|",
                section_separators = "",
            },
        },
    },

    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = "┊",
            show_trailing_blankline_indent = false,
        },
    },

    -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim",         opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },

    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
    },

    -- file explore
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                }
            })
        end,
    },

    -- tab for buffers
    {
        "akinsho/bufferline.nvim",
        -- event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        },
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
    },

    -- Orgmode
    {
        "nvim-orgmode/orgmode",
        config = function()
            require("orgmode").setup({})
        end,
    },
    "mg979/vim-visual-multi", -- multi edit

    "p00f/nvim-ts-rainbow",   -- Raiowparentheses
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end,
    },

    -- Rest client
    {
        "rest-nvim/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },

        ft = { "http" },
        config = function()
            require("rest-nvim").setup({
                -- Open request results in a horizontal split
                result_split_horizontal = false,
                -- Keep the http file buffer above|left when split horizontal|vertical
                result_split_in_place = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = false,
                -- Encode URL before making request
                encode_url = true,
                -- Highlight request on run
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                result = {
                    -- toggle showing URL, HTTP info, headers at top the of result window
                    show_url = true,
                    show_http_info = true,
                    show_headers = true,
                    -- executables or functions for formatting response body [optional]
                    -- set them to false if you want to disable them
                    formatters = {
                        json = "jq",
                        html = function(body)
                            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
                        end,
                    },
                },
                -- Jump to request line on run
                jump_to_request = false,
                env_file = ".env",
                custom_dynamic_variables = {},
                yank_dry_run = true,
            })
        end,
    },
    "towolf/vim-helm",
    -- test project settings
    {
        "klen/nvim-config-local",
        config = function()
            require("config-local").setup({
                -- Default options (optional)

                -- Config file patterns to load (lua supported)
                config_files = { ".nvim.lua", ".nvimrc", ".exrc", ".vimrc.lua", ".vimrc" },

                -- Where the plugin keeps files data
                hashfile = vim.fn.stdpath("data") .. "/config-local",

                autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
                commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
                silent = false,             -- Disable plugin messages (Config loaded/ignored)
                lookup_parents = false,     -- Lookup config files in parent directories
            })
        end,
    },

    "mfussenegger/nvim-lint",
    "f3fora/cmp-spell",
}, {})

require("uelei")
