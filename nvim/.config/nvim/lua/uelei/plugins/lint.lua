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
                javascript = { 'eslint_d' },
                -- typescript = { "eslint_d" },
                -- lua = { 'codespell' },
                go = { 'golangci-lint' },
                python = { 'mypy', 'pylint' },
                terraform = { 'tflint' },
            }

            -- pylint work with virtualenv needs to be installed in the virtualenv
            lint.linters.pylint.cmd = 'python'
            lint.linters.pylint.args = {
                '-m',
                'pylint',
                '-f',
                'json',
                '--from-stdin',
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
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
