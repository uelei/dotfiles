return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
        config = function()
            require('mason').setup {

                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            }
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'codespell', -- spell checker
                    'debugpy',   -- python debugger
                    'pylint',    -- python linter
                    'mypy',      -- python type checker
                    'lua-language-server', -- lua language server
                    'typos-lsp', -- spell checker
                    'basedpyright', -- python language server
                    'pyright',   -- python language server
                    'gopls',     -- go language server
                    'stylua',    -- lua formatter
                    -- "ruff", -- python formatter
                },
            }
        end,
    },
}
