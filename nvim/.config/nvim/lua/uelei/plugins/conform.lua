vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = true,

    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback', lsp_fallback = true }
    end,
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      go = { 'goimports', 'gofmt' },
      markdown = { 'prettierd', 'injected' },
      json = { 'prettierd', 'injected' },
      -- yaml = { 'yamlfix' },
      -- Use a sub-list to run only the first available formatter
      -- You can use a function here to determine the formatters dynamically
      -- python = function(bufnr)
      --   if require('conform').get_formatter_info('ruff_format', bufnr).available then
      --     return { 'ruff_format' }
      --   else
      --     return { 'isort' }
      --   end
      -- end,
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { { 'prettierd', 'prettier' } },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      -- ['_'] = { 'trim_whitespace' },
    },
  },
}
