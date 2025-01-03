return {

    -- {
    --     'akinsho/bufferline.nvim',
    --     active = false,
    --     keys = {
    --         { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>',            desc = 'Toggle pin' },
    --         { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete non-pinned buffers' },
    --         { '<S-h>',      '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev buffer' },
    --         { '<S-l>',      '<cmd>BufferLineCycleNext<cr>',            desc = 'Next buffer' },
    --     },
    --     version = '*',
    --     dependencies = 'nvim-tree/nvim-web-devicons',
    --     opts = {
    --         options = {
    --             offsets = {
    --                 {
    --                     -- filetype = 'neo-tree',
    --                     -- text = 'NeoTree',
    --                     filetype = 'nvim-tree',
    --                     text = 'Nvim-Tree',
    --                     separator = true,
    --                     text_align = 'left',
    --                 },
    --             },
    --             -- diagnostics = 'nvim_lsp',
    --             separator_style = { '', '' },
    --             modified_icon = '●',
    --             show_close_icon = false,
    --             show_buffer_close_icons = false,
    --         },
    --     },
    -- },
    {
        'crispgm/nvim-tabline',
        dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional
        config = true,
    },
}
