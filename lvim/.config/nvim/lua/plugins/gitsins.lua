return {

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                -- See `:help gitsigns.txt`
                -- signs = {
                --     add = { text = '+' },
                --     change = { text = '~' },
                --     delete = { text = '_' },
                --     topdelete = { text = '‾' },
                --     changedelete = { text = '~' },
                -- },
            }
            vim.keymap.set('n', '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
                { desc = 'Next Hunk' })
            vim.keymap.set('n', '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
                { desc = 'Prev Hunk' })
            vim.keymap.set('n', '<leader>gm', "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = 'Blame' })
            vim.keymap.set('n', '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = 'Preview Hunk' })
            vim.keymap.set('n', '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = 'Reset Hunk' })
            -- vim.keymap.set('n', '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = 'Stage Hunk' })
            -- vim.keymap.set('n', '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            --     { desc = 'Undo Stage Hunk' })

            -- vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', { desc = 'Git Diff' })
            vim.keymap.set('n', '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = 'Reset Buffer' })
            vim.keymap.set('n', '<leader>gM', '<cmd>GitBlameToggle<cr>', { desc = 'Blame all' })
        end,
    },

}
