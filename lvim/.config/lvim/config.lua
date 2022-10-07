lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = {
  "all",
}

-- Set a formatter.
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
}

-- Set a linter.
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
}

-- Setup dap for python
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function() require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python") end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function() require("dap-python").test_runner = "pytest" end)

-- Mappings
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
lvim.builtin.which_key.vmappings["d"] = {
  name = "Debug",
  s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
}

lvim.builtin.which_key.mappings["P"] = {
  name = "Python",
  i = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Pick Env" },
  s = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "Show Env" },
  d = { "<cmd>lua require('neogen').generate()<cr>", "Create docstrings" },
}

-- Additional Plugins
lvim.plugins = {
  -- You can switch between vritual environmnts.
  "AckslD/swenv.nvim",
  "mfussenegger/nvim-dap-python",
  {
    -- You can generate docstrings automatically.
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "reST",
            },
          },
        },
      }
    end,
  },
}
