-- local function setup_vim_test()
--   vim.api.nvim_exec(
--     [[
--         " Test config
--         let test#strategy = "neovim"
--         let test#neovim#term_position = "belowright"
--         let g:test#preserve_screen = 1
--         let g:test#echo_command = 1
--         " javascript
--         " let g:test#javascript#runner = 'karma'
--     ]],
--     false
--   )
-- end


local test = require("neotest")
test.setup({
	adapters = {

		pcall(function()
			require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        dap = { justMyCode = false },
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = {"--log-level", "DEBUG"},
        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",

        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
        -- is_test_file = function(file_path)
        -- end,
			})
		end),
		pcall(function()
			require("neotest-jest")({
				jestCommand = "npm test --",
			})
		end),

		pcall(function()
			require("neotest-vim-test")({
				-- It is recommended to add any filetypes that are covered by another adapter to the ignore list
				ignore_file_types = { "python", "vim", "lua" },
			})
		end),
		-- Or to only allow specified file types
		-- require("neotest-vim-test")({ allow_file_types = { "haskell", "elixir" } }),

		pcall(function()
			require("neotest-go")
		end),
	},
	-- setup_vim_test()
})

lvim.builtin.which_key.mappings["t"] = {
	name = "Test",
	a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
	f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
	F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
	l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
	L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
	n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
	N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
	o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
	S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
	s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
}
