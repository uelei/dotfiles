return {

    {
        'alexghergh/nvim-tmux-navigation',

        config = function()
            -- Move to window using the <ctrl> hjkl keys
            local nvim_tmux_nav = require 'nvim-tmux-navigation'
            nvim_tmux_nav.setup {
                disable_when_zoomed = true, -- defaults to false
            }

            vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = 'Go to left window', remap = true })
            vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown,
                { desc = 'Go to lower window', remap = true })
            vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, { desc = 'Go to upper window', remap = true })
            vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight,
                { desc = 'Go to right window', remap = true })

            -- Resize window using <ctrl> arrow keys
            vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
            vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
            vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
            vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
        end

    }
}
