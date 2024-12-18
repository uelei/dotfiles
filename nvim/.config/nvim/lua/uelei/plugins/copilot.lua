return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    opts = {
      debug = true, -- Enable debugging
    },
  },
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
