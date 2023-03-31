vim.opt.relativenumber = true

lvim.format_on_save = false
-- lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- All the treesitter parsers you want to install. If you want all of them, just
-- replace everything with "all".
lvim.builtin.treesitter.ensure_installed = "all"

lvim.lsp.automatic_configuration.skipped_servers = {}

vim.opt.list = true
vim.opt.listchars:append "eol:↴"
