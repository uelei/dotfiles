-- Additional Plugins
lvim.plugins = {

	-- General options
	{
		"j-hui/fidget.nvim", -- ui loading display
		config = function()
			require("fidget").setup({})
		end,
	},
	"mg979/vim-visual-multi", -- multi edit

	"p00f/nvim-ts-rainbow", -- Raiowparentheses
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"npxbr/glow.nvim",
		ft = { "markdown" },
		-- run = "go install github.com/charmbracelet/glow@latest"
	},

	-- Org mode
	"nvim-orgmode/orgmode", -- org mode
	"akinsho/org-bullets.nvim",
	"dhruvasagar/vim-table-mode",
	{
		"lukas-reineke/headlines.nvim",
		config = function()
			require("headlines").setup()
		end,
	},

	-- Python
	-- You can switch between vritual environmnts.
	-- "AckslD/swenv.nvim",
	"mfussenegger/nvim-dap-python",
	{
		-- You can generate docstrings automatically.
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
				languages = {
					python = {
						template = {
							annotation_convention = "reST",
						},
					},
				},
			})
		end,
	},
	{
		"klen/nvim-test",
		config = function()
			require("nvim-test").setup()
		end,
	},

	{
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	},
	-- neotest runners
	-- https://github.com/nvim-neotest/neotest#supported-runners
	{ "nvim-neotest/neotest-python" },
	{ "nvim-neotest/neotest-go" },
	-- { "denmeade/neotest-jest" },

	--[[ For any runner without an adapter you can use neotest-vim-test
  which supports any runner that vim-test supports. The vim-test adapter
  does not support some of the more advanced features such as
  error locations or per-test output. --]]
	-- https://github.com/vim-test/vim-test/
	-- { "vim-test/vim-test", },
	-- { "nvim-neotest/neotest-vim-test" },

	-- git
	"f-person/git-blame.nvim",
	"TimUntersberger/neogit",
	"sindrets/diffview.nvim",

	-- colorscheme
	"bluz71/vim-nightfly-guicolors",
	"sainnhe/sonokai",
	"EdenEast/nightfox.nvim",
	"rakr/vim-one",
	"drewtempelmeyer/palenight.vim",
	"mhartington/oceanic-next",
	"sam4llis/nvim-tundra",

	-- lsp
	"hrsh7th/cmp-emoji",
	{
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},

	-- rust
	"simrat39/rust-tools.nvim",

	-- go
	"olexsmir/gopher.nvim",
	"leoluz/nvim-dap-go",

	-- js ts
	"jose-elias-alvarez/typescript.nvim",
	"mxsdev/nvim-dap-vscode-js",

	-- Rest client
	{
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
	},
}

-- TODO: limpar
