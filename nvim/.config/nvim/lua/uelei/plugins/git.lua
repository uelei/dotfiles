-- Git plugins
return {
    -- Git
    -- {
    --   'NeogitOrg/neogit',
    --   dependencies = {
    --     'nvim-lua/plenary.nvim', -- required
    --     'sindrets/diffview.nvim', -- optional - Diff integration
    --     -- Only one of these is needed, not both.
    --     'nvim-telescope/telescope.nvim', -- optional
    --     'ibhagwan/fzf-lua', -- optional
    --   },
    --   config = function()
    --        vim.keymap.set("n", '<leader>gn', '<cmd>Neogit<cr>', { desc = 'Neogit' })
    -- end
    -- },

    {
        "sindrets/diffview.nvim",
        config = function()
            vim.keymap.set("n", '<leader>gm', '<cmd>DiffviewOpen<cr>', { desc = 'Lazygit' })
        end


    },


    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
        config = function()
            vim.keymap.set("n", '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
                { desc = 'Next Hunk' })
            vim.keymap.set("n", '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
                { desc = 'Prev Hunk' })
            vim.keymap.set("n", '<leader>gl', "<cmd>lua require 'gitsigns'.blame_line()<cr>", { desc = 'Blame' })
            vim.keymap.set("n", '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = 'Preview Hunk' })
            vim.keymap.set("n", '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = 'Reset Hunk' })
            vim.keymap.set("n", '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = 'Stage Hunk' })
            vim.keymap.set("n", '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                { desc = 'Undo Stage Hunk' })

            vim.keymap.set("n", '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', { desc = 'Git Diff' })
            vim.keymap.set("n", '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = 'Reset Buffer' })
            vim.keymap.set("n", '<leader>gL', '<cmd>GitBlameToggle<cr>', { desc = 'Blame all' })
        end

    },

    {
        'f-person/git-blame.nvim',
        init = function()
            -- vim.g.gitblame_message_template = " <author> - <date> - <summary> - <sha>"
            vim.g.gitblame_enabled = 0
        end,
    },
    'sindrets/diffview.nvim',
    {
        'ruifm/gitlinker.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        opts = {},
    },
    -- lazygit
    {
        'kdheepak/lazygit.nvim',
        -- optional for floating window border decoration
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            vim.keymap.set("n", '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Lazygit' })
        end

    },
}
