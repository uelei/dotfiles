local fn = vim.fn
-- FIX vai
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
  "git",
  "clone",
  "--depth",
  "1",
  "https://github.com/wbthomason/packer.nvim",
  install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
 display = {
  open_fn = function()
      return require("packer.util").float({ border = "rounded" })
  end,
 },
})

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    use "akinsho/bufferline.nvim"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    -- use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"
    use "folke/which-key.nvim"
    use "mg979/vim-visual-multi"

    --  NvimTree
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"

    -- Colorschemes
    use "folke/tokyonight.nvim"
    use "joshdick/onedark.vim"
    use "rakr/vim-one"

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-emoji"
    use "hrsh7th/cmp-nvim-lsp-signature-help"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    -- use {
    --   "neovim/nvim-lspconfig", -- LSP support
    --   -- opt = true,
    --   event = "BufReadPre",
    --   wants = { "nvim-lsp-installer", "cmp-nvim-lsp", "lua-dev.nvim", "vim-illuminate", "null-ls.nvim", "j-hui/fidget.nvim"},
    --   requires = {
    --     "williamboman/nvim-lsp-installer", -- simple installer for LSP servers
    --     "folke/lua-dev.nvim", -- lua-dev.nvim is a plugin for nvim that provides LSP support for Lua
    --     "RRethy/vim-illuminate",
    --     "tamago324/nlsp-settings.nvim", -- server settings defined in json for lsp
    --     "jose-elias-alvarez/null-ls.nvim",
    --     "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
    --
    --     "lvimuser/lsp-inlayhints.nvim", -- inlay hints
    --     {
    --       "j-hui/fidget.nvim", -- visual status for lsp loading
    --       config = function()
    --           require("fidget").setup {}
    --       end,
    --     },
    --   },
    -- }

    use "neovim/nvim-lspconfig" -- enable LSP

    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    -- use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
    use "RRethy/vim-illuminate"
    use { "j-hui/fidget.nvim", config = function()
              require("fidget").setup {}
          end }
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({
                -- your configuration
            })
        end,
    })

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "hashivim/vim-terraform"
    use "p00f/nvim-ts-rainbow" -- Raiowparentheses

    -- Coment
    use {
    'numToStr/Comment.nvim', -- Easily comment stuff
    commit = "fe9bbdbcd2f1b85cc8fccead68122873d94f8397",
    config = function()
        require('Comment').setup()
    end
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Git
    use { "TimUntersberger/neogit", requires = { "nvim-lua/plenary.nvim",
                                                 "sindrets/diffview.nvim" } }
    use "lewis6991/gitsigns.nvim"
    use {
      "f-person/git-blame.nvim",
      event = "BufRead",
      config = function()
          vim.cmd("highlight default link gitblame SpecialComment")
          vim.g.gitblame_enabled = 0
      end,
    }

    -- Copilot
    use {"github/copilot.vim", commit="da286d8c52159026f9cba16cd0f98b609c056841"}
    use "hrsh7th/cmp-copilot"

    -- DAP
    use { "mfussenegger/nvim-dap" }
    use { "rcarriga/nvim-dap-ui" }
    -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

    --  use {
    -- 	"mfussenegger/nvim-dap",
    -- 	-- opt = true,
    -- 	-- event = "BufReadPre",
    -- 	-- module = { "dap" },
    -- 	wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "which-key.nvim" },
    -- 	requires = {
    -- 		"theHamsta/nvim-dap-virtual-text",
    --      "mfussenegger/nvim-dap-python",
    -- 		"rcarriga/nvim-dap-ui",
    -- 		-- { "leoluz/nvim-dap-go", module = "dap-go" },
    -- 	},
    -- 	-- config = function()
    -- 	-- 	require("user.dap").setup()
    -- 	-- end,
    -- }

    -- Python
    use {
        "klen/nvim-test",
        config = function()
          require('nvim-test').setup()
        end
      }
    use "tjdevries/apyrori.nvim"
    use "mfussenegger/nvim-dap-python"

    -- Python Test
    use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python"
    }
    }

    -- Rest client
    use {
        "NTBBloodbath/rest.nvim",
        commit = "e5f68db73276c4d4d255f75a77bbe6eff7a476ef",
        requires = { "nvim-lua/plenary.nvim" },
        opt = false,
        ft = { "http" },
        config = function()
            require("rest-nvim").setup({
                result_split_horizontal = false,
            })
        end,
    }

    use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup {
        }
    end
    }

    use "chrisbra/Colorizer"
    -- use "ap/vim-css-color"
    -- use {
    --   "klen/nvim-test",
    --   config = function()
    --   require('nvim-test').setup()
    --   end
    -- }
    -- use "vim-test/vim-test"

    -- ORG
    use "nvim-orgmode/orgmode"

    -- Notify
    use {
      "rcarriga/nvim-notify", config = function()
          vim.notify = require("notify")
      end
    }
    use {
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
    }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
