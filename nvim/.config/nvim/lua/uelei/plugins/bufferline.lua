return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
  },
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      offsets = {
        {
          -- filetype = 'neo-tree',
          -- text = 'NeoTree',
          filetype = 'nvim-tree',
          text = 'Nvim-Tree',
          separator = true,
          text_align = 'left',
        },
      },
      -- diagnostics = 'nvim_lsp',
      separator_style = { '', '' },
      modified_icon = '●',
      show_close_icon = false,
      show_buffer_close_icons = false,
    },
  },
}
