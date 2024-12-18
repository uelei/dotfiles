return {
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        config = function()
            vim.keymap.set('n', '<leader>mcc', '<cmd>CopilotChat<cr>', { desc = 'CopilotChat' })
            vim.keymap.set('n', '<leader>mcd', '<cmd>CopilotChatDocs<cr>', { desc = 'Create Documentation' })
            vim.keymap.set('n', '<leader>mct', '<cmd>CopilotChatTests<cr>', { desc = 'Generate tests for my code' })
            vim.keymap.set('n', '<leader>mcm', '<cmd>CopilotChatCommitStaged<cr>', { desc = 'Generate Commit message' })
            vim.keymap.set('n', '<leader>mci', '<cmd>CopilotChatOptimize<cr>', { desc = 'Improve Selected code' })
            vim.keymap.set('n', '<leader>mcq', function()
                local input = vim.fn.input 'Quick Chat: '
                if input ~= '' then
                    require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
                end
            end, { desc = 'CopilotChat - Quick chat' })
            require('CopilotChat').setup { debug = true }
        end,
    },
    {
        'zbirenbaum/copilot.lua',

        config = function()
            -- require('copilot_cmp').setup()
            require('copilot').setup {
                suggestion = { enabled = false },
                panel = { enabled = false },
            }
        end,
        -- {
        --     'zbirenbaum/copilot-cmp',
        --     config = function()
        --         require('copilot_cmp').setup()
        --
        --         require('copilot').setup {
        --             suggestion = { enabled = false },
        --             panel = { enabled = false },
        --         }
        --     end,
        -- },
    },
}
