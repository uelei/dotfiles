return {
    -- {
    --   'nvim-neo-tree/neo-tree.nvim',
    --   version = '*',
    --   dependencies = {
    --     'nvim-lua/plenary.nvim',
    --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    --     'MunifTanjim/nui.nvim',
    --   },
    --   config = function()
    --     require('neo-tree').setup {}
    --   end,
    --   --  keys = {
    --   --  { '<leader>fe', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    --   -- },
    -- },

    -- file explore
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup {
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                },
            }
        end,
        keys = {
            { '<leader>fe', '<cmd>NvimTreeToggle<cr>', desc = 'File Explore' },
        },
    },
}
