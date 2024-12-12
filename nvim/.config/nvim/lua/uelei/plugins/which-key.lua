return {
    {                   -- Useful plugin to show you pending keybinds.
        'folke/which-key.nvim',
        event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
        config = function() -- This is the function that runs, AFTER loading
            local wk = require 'which-key'
            wk.setup()

            wk.add {
                -- Buffer
                { '<leader>b', group = 'Buffer', icon = '' },
                { '<leader>bc', '<cmd>bdelete<cr>', desc = 'Close' },
                { '<leader>bt', '<cmd>terminal<cr>', desc = 'Terminal' },
                -- File
                { '<leader>f', group = 'File', icon = '' },
                { '<leader>fa', '<cmd>%y<cr>', desc = 'Buffer contents' },
                { '<leader>ff', "<cmd>let @+ = expand('%:p')<cr> <cmd>lua vim.notify('Yanked full path')<cr>", desc = 'Full Path' },
                { '<leader>fn', '<cmd>new<cr>', desc = 'New File' },
                { '<leader>fp', "<cmd>let @+ = expand('%:~:.')<cr> <cmd>lua vim.notify('Yanked relative path')<cr>", desc = 'Relative Path' },
                -- Git
                { '<leader>g', group = 'Git', icon = '' },
                { '<leader>mc', group = 'CopilotChat', icon = ' ' },
                -- LSP
                { '<leader>l', group = '+Lsp', icon = '' },

                -- windows
                { '<leader>w', group = '+Window', icon = '' },
                { '<leader>ww', '<C-W>p', desc = 'Other window', remap = true },
                { '<leader>wd', '<C-W>c', desc = 'Delete window', remap = true },
                { '<leader>w-', '<C-W>s', desc = 'Split window below', remap = true },
                { '<leader>w|', '<C-W>v', desc = 'Split window right', remap = true },
                { '<leader>-', '<C-W>s', desc = 'Split window below', remap = true },
                { '<leader>|', '<C-W>v', desc = 'Split window right', remap = true },

                { '<leader>dP', group = '+Python' },
            }
        end,
    },
}
