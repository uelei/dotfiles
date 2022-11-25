require("uelei.lsp.languages.rust")
require("uelei.lsp.languages.go")
require("uelei.lsp.languages.python")
require("uelei.lsp.languages.js-ts")

lvim.lsp.diagnostics.virtual_text = false

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "markdownlint", filetypes = { "markdown" } },
})

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

-- Extras lsp
require("lspconfig").marksman.setup({})
require("lspconfig").tflint.setup({})
