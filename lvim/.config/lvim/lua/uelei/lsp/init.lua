require("uelei.lsp.languages.rust")
require("uelei.lsp.languages.go")
require("uelei.lsp.languages.python")
require("uelei.lsp.languages.js-ts")

lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "all"

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "google_java_format", filetypes = { "java" } },
  { command = "stylua", filetypes = { "lua" } },
}

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint_d", filetypes = { "javascript" } },
-- }
