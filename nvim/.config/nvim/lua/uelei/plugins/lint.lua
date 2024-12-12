return {
    {
        'mfussenegger/nvim-lint',
        active = false,
        event = {
            'BufReadPre',
            'BufNewFile',
        },
        config = function()
            local lint = require 'lint'

            lint.linters_by_ft = {
                javascript = { 'eslint_d', 'codespell' },
                -- typescript = { "eslint_d" },
                go = { 'golangci-lint', 'codespell' },
                python = { 'mypy', 'pylint', 'codespell' },
                terraform = { 'tflint', 'codespell' },
            }

            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })

            vim.keymap.set('n', '<leader>fl', function()
                lint.try_lint()
            end, { desc = 'Trigger linting for current file' })
        end,
    },
}
