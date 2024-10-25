
  return { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = nil,
        lsp_fallback = true,
      },
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
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
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
