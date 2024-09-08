return {
  'zbirenbaum/copilot.lua',
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()

    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
    end,
  },
}
