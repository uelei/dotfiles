--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.keys.visual_mode['<C-_>'] = '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>'
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }
-- lvim.keys.insert_mode = {
-- -- 	-- Disable arrow keys
-- -- 	{ "<Up>", "<NOP>" },
-- -- 	{ "<Down>", "<NOP>" },
-- -- 	{ "<Left>", "<NOP>" },
-- -- 	{ "<Right>", "<NOP>" },

--   },
-- }

lvim.keys.insert_mode['<C-_>'] = '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>'
-- lvim.keys.normal_mode = {

-- 	-- Alternative way to save
-- 	{ "<C-s>", ":w<CR>" },

-- 	-- Use CTRL+C instead of <ESC>...
-- 	{ "<C-c>", "<ESC>" },

-- 	-- Better window movement
-- 	{ "<C-h>", "<C-w>h" },
-- 	{ "<C-j>", "<C-w>j" },
-- 	{ "<C-k>", "<C-w>k" },
-- 	{ "<C-l>", "<C-w>l" },

-- 	-- Resize with arrows
-- 	{ "<Up>", ":resize +2<CR>" },
-- 	{ "<Down>", ":resize -2<CR>" },
-- 	{ "<Left>", ":vertical resize -2<CR>" },
-- 	{ "<Right>", ":vertical resize +2<CR>" },

-- 	-- QuickFix
-- 	{ "]q", ":cnext<CR>" },
-- 	{ "[q", ":cprev<CR>" },
-- 	{ "<C-q>", ":call QuickFixToggle()<CR>" },

-- 	-- LSP/Trouble
-- 	{ "gR", "<cmd>Trouble lsp_references<CR>" },
-- }

-- lvim.keys.term_mode = {
-- 	-- Terminal window navigation
-- 	{ "<C-h>", "<C-\\><C-N><C-w>h" },
-- 	{ "<C-j>", "<C-\\><C-N><C-w>j" },
-- 	{ "<C-k>", "<C-\\><C-N><C-w>k" },
-- 	{ "<C-l>", "<C-\\><C-N><C-w>l" },
-- }

-- lvim.keys.visual_mode = {
-- 	-- Better indenting
-- 	{ "<", "<gv" },
-- 	{ ">", ">gv" },

-- 	-- Paste most recent yank
-- 	{ "p", '"0p', { silent = true } },
-- 	{ "P", '"0P', { silent = true } },
-- }

-- lvim.keys.visual_block_mode = {
-- 	-- Move selected line / block of text in visual mode
-- 	{ "K", ":move '<-2<CR>gv-gv" },
-- 	{ "J", ":move '>+1<CR>gv-gv" },
-- }



-- *
-- Telescope
-- *
lvim.builtin.telescope.active = true
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git", "node_modules" }
local get_telescope_mappings = function()
	local actions = require("telescope.actions")
	return {
		i = {
			["<C-n>"] = actions.cycle_history_next,
			["<C-p>"] = actions.cycle_history_prev,
			["<C-c>"] = actions.close,
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			["<CR>"] = actions.select_default + actions.center,
			["<c-x>"] = false,
		},
		n = {
			["<C-j>"] = actions.move_selection_next,
			["<C-k>"] = actions.move_selection_previous,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
		},
	}
end
lvim.builtin.telescope.defaults.mappings = get_telescope_mappings()

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.notify.active = true


-- Dashboard
-- *
lvim.builtin.dashboard.active = true
lvim.builtin.dashboard.custom_section.a.command = "Telescope find_files find_command=rg,--ignore,--hidden,--files"

-- *
-- Terminal
-- *
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shading_factor = 1

-- *
-- Nvimtree
-- *
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.nvimtree.setup.hide_dotfiles = 0

-- *
-- Treesitter
-- *
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true


-- *
-- Whichkey
-- *
lvim.builtin.which_key.active = true
lvim.builtin.which_key.mappings["w"] = { "<cmd>w<CR>", "Save" }
lvim.builtin.which_key.mappings["W"] = { "<cmd>w!<CR>", "Force Save" }
lvim.builtin.which_key.mappings["q"] = { "<cmd>q<CR>", "Quit" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>q!<CR>", "Force Quit" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" }
-- lvim.builtin.which_key.mappings["b"]["c"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search Current Buffer" }
-- lvim.builtin.which_key.mappings["s"]["f"] = {
-- 	"<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>",
-- 	"Find File",
-- }
-- lvim.builtin.which_key.mappings["s"]["m"] = { "<cmd>Telescope marks<cr>", "Search Marks" }
-- lvim.builtin.which_key.mappings["s"]["g"] = { "<cmd>Telescope git_files<cr>", "Search Git Files" }
lvim.builtin.which_key.mappings["t"] = {
	name = "Toggle",
	h = { "<cmd>set hlsearch!<CR>", "Toggle Highlight" },
	q = { "<cmd>call QuickFixToggle()<CR>", "Toggle Quick Fix List" },
	b = { "<cmd>GitBlameToggle<CR>", "Toggle Git Blame" },
	t = { "<cmd>Twilight<CR>", "Toggle Twilight" },
	i = { "<cmd>IndentBlanklineToggle<CR>", "Toggle Indent Line" },
	x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
}
-- lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<CR>", "Zen Mode" }
lvim.builtin.which_key.mappings["x"] = {
	name = "Trouble",
	w = { "<cmd>Trouble lsp_workspace_diagnostics<CR>", "Trouble Workspaces" },
	d = { "<cmd>Trouble lsp_document_diagnostics<CR>", "Trouble Document" },
	l = { "<cmd>Trouble loclist<CR>", "Trouble Location List" },
	q = { "<cmd>Trouble quickfix<CR>", "Trouble Quickfix List" },
}
-- Dap
lvim.builtin.dap.active = true
require('dap.ext.vscode').load_launchjs()

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  -- {
  --   command = "codespell",
  --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --   filetypes = { "javascript", "python" },
  -- },
}

-- Additional Plugins
lvim.plugins = {
  	{
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("highlight default link gitblame SpecialComment")
			vim.g.gitblame_enabled = 0
		end,
	},
{"kdheepak/lazygit.nvim"},
{
"pr4th4m/coc-restclient"
  },
 {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "lsp_document_diagnostics",
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- preview item
					next = "j", -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = true, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				use_lsp_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
			})
		end,
	},

}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
