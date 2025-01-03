-- dap.lua
return {

    {
        'mfussenegger/nvim-dap',
        recommended = true,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            {
                'mfussenegger/nvim-dap-python',
                keys = {
                    {
                        '<leader>dPt',
                        function()
                            require('dap-python').test_method()
                        end,
                        desc = 'Test Debug Method',
                        ft = 'python',
                    },
                    {
                        '<leader>dPc',
                        function()
                            require('dap-python').test_class()
                        end,
                        desc = 'Test Debug Class',
                        ft = 'python',
                    },
                },
                ft = 'python',
            },
        },
        event = 'VeryLazy',
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'

            dap.set_log_level 'ERROR'
            dapui.setup()

            -- Python setup

            local mason_debugpy_path = require('mason-registry').get_package('debugpy'):get_install_path()
            -- local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
            local debugpy_path = mason_debugpy_path .. '/venv/bin/python'

            local dap_python = require 'dap-python'
            require('dap.ext.vscode').load_launchjs('.vscode/launch.json', {
                python = {
                    'python',
                },
            })
            dap_python.setup(debugpy_path)
            dap_python.default_port = 5678

            dap_python.test_runner = 'pytest'
            -- dap.adapters.python = function(cb, config)
            --   if config.request == 'attach' then
            --     ---@diagnostic disable-next-line: undefined-field
            --     local port = (config.connect or config).port
            --     ---@diagnostic disable-next-line: undefined-field
            --     local host = (config.connect or config).host or '127.0.0.1'
            --     cb {
            --       type = 'server',
            --       port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            --       host = host,
            --       options = {
            --         source_filetype = 'python',
            --       },
            --     }
            --   else
            --     cb {
            --       type = 'executable',
            --       command = debugpy_path,
            --       args = { '-m', 'debugpy.adapter' },
            --       options = {
            --         source_filetype = 'python',
            --       },
            --     }
            --   end
            -- end
            --
            -- dap.configurations.python = {
            --   {
            --     -- The first three options are required by nvim-dap
            --     type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
            --     request = 'launch',
            --     name = 'Launch file',
            --
            --     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
            --
            --     program = '${file}', -- This configuration will launch the current file if used.
            --     pythonPath = function()
            --       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            --       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            --       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            --       local cwd = vim.fn.getcwd()
            --       local venv = os.getenv 'VIRTUAL_ENV'
            --       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            --         return cwd .. '/venv/bin/python'
            --       elseif venv then
            --         return venv .. '/bin/python'
            --       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            --         return cwd .. '/.venv/bin/python'
            --       else
            --         return '/usr/bin/python'
            --       end
            --     end,
            --   },
            -- }

            -- Elixir setup
            --       local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
            --       if elixir_ls_debugger ~= '' then
            --         dap.adapters.mix_task = {
            --           type = 'executable',
            --           command = elixir_ls_debugger,
            --         }
            --
            --         dap.configurations.elixir = {
            --           {
            --             type = 'mix_task',
            --             name = 'phoenix server',
            --             task = 'phx.server',
            --             request = 'launch',
            --             projectDir = '${workspaceFolder}',
            --             exitAfterTaskReturns = false,
            --             debugAutoInterpretAllModules = false,
            --           },
            --         }
            --       end

            -- go setup
            dap.adapters.delve = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = 'dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}' },
                    -- add this if on windows, otherwise server won't open successfully
                    -- detached = false
                },
            }

            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            dap.configurations.go = {
                {
                    type = 'delve',
                    name = 'Debug',
                    request = 'launch',
                    program = '${file}',
                },
                {
                    type = 'delve',
                    name = 'Debug test', -- configuration for debugging test files
                    request = 'launch',
                    mode = 'test',
                    program = '${file}',
                },
                -- works with go.mod packages and sub packages
                {
                    type = 'delve',
                    name = 'Debug test (go.mod)',
                    request = 'launch',
                    mode = 'test',
                    program = './${relativeFileDirname}',
                },
            }

            -- Basic debugging keymaps, feel free to change to your liking!
            local wk = require 'which-key'
            wk.add {

                { '<leader>d', '', desc = '+debug', mode = { 'n', 'v' } },
                {
                    '<leader>dB',
                    function()
                        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                    end,
                    desc = 'Breakpoint Condition',
                },
                {
                    '<leader>db',
                    function()
                        require('dap').toggle_breakpoint()
                    end,
                    desc = 'Toggle Breakpoint',
                },
                {
                    '<leader>dc',
                    function()
                        require('dap').continue()
                    end,
                    desc = 'Continue',
                },
                {
                    '<leader>da',
                    function()
                        require('dap').continue { before = get_args }
                    end,
                    desc = 'Run with Args',
                },
                {
                    '<leader>dC',
                    function()
                        require('dap').run_to_cursor()
                    end,
                    desc = 'Run to Cursor',
                },
                {
                    '<leader>dg',
                    function()
                        require('dap').goto_()
                    end,
                    desc = 'Go to Line (No Execute)',
                },
                {
                    '<leader>di',
                    function()
                        require('dap').step_into()
                    end,
                    desc = 'Step Into',
                },
                {
                    '<leader>dj',
                    function()
                        require('dap').down()
                    end,
                    desc = 'Down',
                },
                {
                    '<leader>dk',
                    function()
                        require('dap').up()
                    end,
                    desc = 'Up',
                },
                {
                    '<leader>dl',
                    function()
                        require('dap').run_last()
                    end,
                    desc = 'Run Last',
                },
                {
                    '<leader>do',
                    function()
                        require('dap').step_out()
                    end,
                    desc = 'Step Out',
                },
                {
                    '<leader>dO',
                    function()
                        require('dap').step_over()
                    end,
                    desc = 'Step Over',
                },
                {
                    '<leader>dp',
                    function()
                        require('dap').pause()
                    end,
                    desc = 'Pause',
                },
                {
                    '<leader>dr',
                    function()
                        require('dap').repl.toggle()
                    end,
                    desc = 'Toggle REPL',
                },
                {
                    '<leader>ds',
                    function()
                        require('dap').session()
                    end,
                    desc = 'Session',
                },
                {
                    '<leader>dt',
                    function()
                        require('dap').terminate()
                    end,
                    desc = 'Terminate',
                },
                {
                    '<leader>dw',
                    function()
                        require('dap.ui.widgets').hover()
                    end,
                    desc = 'Widgets',
                },

                {
                    '<leader>du',
                    function()
                        require('dapui').toggle()
                    end,
                    desc = 'UI Toggle',
                },
            }

            -- Dap UI setup
            -- For more information, see |:help nvim-dap-ui|
            dapui.setup {
                -- Set icons to characters that are more likely to work in every terminal.
                --    Feel free to remove or use ones that you like more! :)
                --    Don't feel like these are good choices.
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    icons = {
                        pause = '',
                        play = '',
                        step_into = '',
                        step_over = '',
                        step_out = '',
                        step_back = '',
                        run_last = '',
                        terminate = '',
                    },
                },

                layouts = {
                    {
                        elements = {
                            'scopes',
                            -- 'breakpoints',
                            'stacks',
                            -- 'watches',
                        },
                        size = 40,
                        position = 'left',
                    },
                    {
                        elements = {
                            'repl',
                            'console',
                        },
                        size = 10,
                        position = 'bottom',
                    },
                },
            }
            vim.fn.sign_define('DapStopped',
                { text = '󰁕 ', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = 'DapStoppedLine' })

            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticInfo' })
            vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticError' })
            vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo' })
            vim.fn.sign_define('DapLogPoint', { text = '.>', texthl = 'DiagnosticInfo' })
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function() end
            dapui.close()

            --     -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            -- vim.keymap.set('n', '<leader>cx', dapui.toggle, { desc = 'Debug: See last session result.' })
        end,
    },
}
