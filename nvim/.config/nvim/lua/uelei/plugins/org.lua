-- Orgmode
return {
  {
    'nvim-orgmode/orgmode',
    -- config = function()
    --     require("orgmode").setup({})
    -- end,
  },
  {
    'andreadev-it/orgmode-multi-key',
    config = function()
      require('orgmode-multi-key').setup()
    end,
  },
  'danilshvalov/org-modern.nvim',
  {
    'akinsho/org-bullets.nvim',
    config = function()
      require('org-bullets').setup()
    end,
  },
}
