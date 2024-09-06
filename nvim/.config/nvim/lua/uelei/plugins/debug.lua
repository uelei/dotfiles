-- -- debug.lua
-- --
-- -- Shows how to use the DAP plugin to debug your code.
-- --
-- -- Primarily focused on configuring the debugger for Go, but can
-- -- be extended to other languages as well. That's why it's called
-- -- kickstart.nvim and not kitchen-sink.nvim ;)
--
-- return {
--   -- NOTE: Yes, you can install new plugins here!
--   'mfussenegger/nvim-dap',
--   -- NOTE: And you can specify dependencies as well
--   dependencies = {
--     -- Creates a beautiful debugger UI
--     'rcarriga/nvim-dap-ui',
--     'nvim-neotest/nvim-nio',
--     -- Installs the debug adapters for you
--     'williamboman/mason.nvim',
--     'jay-babu/mason-nvim-dap.nvim',
--
--     -- Add your own debuggers here
--     -- 'leoluz/nvim-dap-go',
--   },
--   config = function()
--     local dap = require 'dap'
--     local dapui = require 'dapui'
--
--     require('mason-nvim-dap').setup {
--       -- Makes a best effort to setup the various debuggers with
--       -- reasonable debug configurations
--       automatic_setup = true,
--
--       -- You can provide additional configuration to the handlers,
--       -- see mason-nvim-dap README for more information
--       handlers = {},
--
--       -- You'll need to check that you have the required things installed
--       -- online, please don't ask me how to install them :)
--       ensure_installed = {
--         -- Update this to ensure that you have the debuggers for the langs you want
--         'delve',
--         'debugpy',
--       },
--     }
--     dap.listeners.before.attach.dapui_config = function()
--       dapui.open()
--     end
--     dap.listeners.before.launch.dapui_config = function()
--       dapui.open()
--     end
--     dap.listeners.before.event_terminated.dapui_config = function()
--       dapui.close()
--     end
--     dap.listeners.before.event_exited.dapui_config = function()
--       dapui.close()
--     end
--     -- Basic debugging keymaps, feel free to change to your liking!
--     vim.keymap.set('n', '<leader>cs', dap.step_into, { desc = 'Debug: Step Into' })
--     vim.keymap.set('n', '<leader>co', dap.step_over, { desc = 'Debug: Step Over' })
--     vim.keymap.set('n', '<leader>cu', dap.step_out, { desc = 'Debug: Step Out' })
--     vim.keymap.set('n', '<leader>cc', dap.continue, { desc = 'Debug: Start/Continue' })
--     vim.keymap.set('n', '<leader>cb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
--     vim.keymap.set('n', '<leader>cB', function()
--       dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
--     end, { desc = 'Debug: Set Breakpoint' })
--
--     -- Dap UI setup
--     -- For more information, see |:help nvim-dap-ui|
--     dapui.setup {
--       -- Set icons to characters that are more likely to work in every terminal.
--       --    Feel free to remove or use ones that you like more! :)
--       --    Don't feel like these are good choices.
--       icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
--       controls = {
--         icons = {
--           pause = '⏸',
--           play = '▶',
--           step_into = '⏎',
--           step_over = '⏭',
--           step_out = '⏮',
--           step_back = 'b',
--           run_last = '▶▶',
--           terminate = '⏹',
--           disconnect = '⏏',
--         },
--       },
--     }
--
--     -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
--     vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
--
--     -- dap.listeners.after.event_initialized['dapui_config'] = dapui.open
--     -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
--     -- dap.listeners.before.event_exited['dapui_config'] = dapui.close
--
--     -- Install golang specific config
--     -- require('dap-go').setup()
--   end,
-- }
--
-- -- return {
-- --   'mfussenegger/nvim-dap',
-- --   dependencies = {
-- --     'rcarriga/nvim-dap-ui',
-- --   },
-- --   config = function()
-- --     local dap = require 'dap'
-- --     local dapui = require 'dapui'
-- --
-- --     require('dapui').setup()
-- --     require('dap-go').setup()
-- --
-- --     dap.listeners.before.attach.dapui_config = function()
-- --       dapui.open()
-- --     end
-- --     dap.listeners.before.launch.dapui_config = function()
-- --       dapui.open()
-- --     end
-- --     dap.listeners.before.event_terminated.dapui_config = function()
-- --       dapui.close()
-- --     end
-- --     dap.listeners.before.event_exited.dapui_config = function()
-- --       dapui.close()
-- --     end
-- --
-- --     vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, {})
-- --     vim.keymap.set('n', '<Leader>dc', dap.continue, {})
-- --   end,
-- -- }

-- return {
--     {
--         'mfussenegger/nvim-dap',
--         dependencies = {
--             'rcarriga/nvim-dap-ui',
--             -- 'theHamsta/nvim-dap-virtual-text',
--             'williamboman/mason.nvim',
--             'nvim-neotest/nvim-nio',
--             'jay-babu/mason-nvim-dap.nvim',
--             'mfussenegger/nvim-dap-python',
--             'leoluz/nvim-dap-go',
--         },
--         config = function()
--             local dap = require 'dap'
--             local dapui = require 'dapui'
--             local dap_python = require 'dap-python'
--
--             local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
--             local debugpy_path = mason_path .. 'packages/debugpy/venv/Scripts/python'
--
--             dapui.setup()
--             dap_python.setup(debugpy_path)
--             dap_python.default_port = 38000
--
--             dap.listeners.after.event_initialized.dapui_config = dapui.open
--             dap.listeners.before.event_terminated.dapui_config = dapui.close
--             dap.listeners.before.event_exited.dapui_config = dapui.close
--
--     -- Basic debugging keymaps, feel free to change to your liking!
--     vim.keymap.set('n', '<leader>cs', dap.step_into, { desc = 'Debug: Step Into' })
--     vim.keymap.set('n', '<leader>co', dap.step_over, { desc = 'Debug: Step Over' })
--     vim.keymap.set('n', '<leader>cu', dap.step_out, { desc = 'Debug: Step Out' })
--     vim.keymap.set('n', '<leader>cc', dap.continue, { desc = 'Debug: Start/Continue' })
--     vim.keymap.set('n', '<leader>cb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
--     vim.keymap.set('n', '<leader>cB', function()
--       dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
--     end, { desc = 'Debug: Set Breakpoint Cond.' })
--
--     -- Dap UI setup
--     -- For more information, see |:help nvim-dap-ui|
--     dapui.setup {
--       -- Set icons to characters that are more likely to work in every terminal.
--       --    Feel free to remove or use ones that you like more! :)
--       --    Don't feel like these are good choices.
--       icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
--       controls = {
--         icons = {
--           pause = '⏸',
--           play = '▶',
--           step_into = '⏎',
--           step_over = '⏭',
--           step_out = '⏮',
--           step_back = 'b',
--           run_last = '▶▶',
--           terminate = '⏹',
--           disconnect = '⏏',
--         },
--       },
--     }
--
--         end
--     }
-- }
--








return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',
            'mfussenegger/nvim-dap-python',
            'leoluz/nvim-dap-go',
        },
        lazy = true,
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            local dap_python = require 'dap-python'

            local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
            local debugpy_path = mason_path .. 'packages/debugpy/venv/bin/python'
            if IS_WINDOWS then
                debugpy_path = mason_path .. 'packages/debugpy/venv/Scripts/python'
            end

            dapui.setup()
            dap_python.setup(debugpy_path)
            dap_python.default_port = 5678

            -- require('mason-nvim-dap').setup {
            --     automatic_installation = true,
            --     handlers = {},
            --     ensure_installed = {
            --         'python',
            --         'delve',
            --     },
            -- }
            dap.listeners.after.event_initialized.dapui_config = dapui.open
            dap.listeners.before.event_terminated.dapui_config = dapui.close
            dap.listeners.before.event_exited.dapui_config = dapui.close
            -- require('nvim-dap-virtual-text').setup {
            --     -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
            --     display_callback = function(variable)
            --         local name = string.lower(variable.name)
            --         local value = string.lower(variable.value)
            --         if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
            --             return '*****'
            --         end
            --
            --         if #variable.value > 15 then
            --             return ' ' .. string.sub(variable.value, 1, 15) .. '... '
            --         end
            --
            --         return ' ' .. variable.value
            --     end,
            -- }

            -- table.insert(dap.configurations.python, {
            --     type = 'python',
            --     request = 'launch',
            --     name = 'My custom launch configuration',
            --     program = '${file}',
            --     -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
            -- })

            -- dap.adapters.go = {
            --     type = 'server',
            --     port = '${port}',
            --     executable = {
            --         command = 'dlv',
            --         args = { 'dap', '-l', '127.0.0.1:${port}' },
            --     },
            -- }

            -- local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
            -- if elixir_ls_debugger ~= '' then
            --     dap.adapters.mix_task = {
            --         type = 'executable',
            --         command = elixir_ls_debugger,
            --     }
            --
            --     dap.configurations.elixir = {
            --         {
            --             type = 'mix_task',
            --             name = 'phoenix server',
            --             task = 'phx.server',
            --             request = 'launch',
            --             projectDir = '${workspaceFolder}',
            --             exitAfterTaskReturns = false,
            --             debugAutoInterpretAllModules = false,
            --         },
            --     }
            -- end

            -- vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
            -- vim.keymap.set('n', '<space>gb', dap.run_to_cursor)
            --
            -- -- Eval var under cursor
            -- -- vim.keymap.set('n', '<space>?', function()
            -- --     require('dapui').eval(nil, { enter = true })
            -- -- end)
            --
            -- vim.keymap.set('n', '<F1>', dap.continue)
            -- vim.keymap.set('n', '<F2>', dap.step_into)
            -- vim.keymap.set('n', '<F3>', dap.step_over)
            -- vim.keymap.set('n', '<F4>', dap.step_out)
            -- vim.keymap.set('n', '<F5>', dap.step_back)
            -- vim.keymap.set('n', '<F13>', dap.restart)

            -- dap.listeners.before.launch.dapui_config = dapui.open()

            -- dapui.setup {
            --     icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            --     controls = {
            --         -- icons = {
            --         --     pause = '⏸',
            --         --     play = '▶',
            --         --     step_into = '⏎',
            --         --     step_over = '⏭',
            --         --     step_out = '⏮',
            --         --     step_back = 'b',
            --         --     run_last = '▶▶',
            --         --     terminate = '⏹',
            --         --     disconnect = '⏏',
            --         -- },
            --     },
            -- }

            -- dap.listeners.before.attach.dapui_config = function()
            --     ui.open()
            -- end
            -- dap.listeners.before.launch.dapui_config = function()
            --     ui.open()
            -- end
            -- dap.listeners.before.event_terminated.dapui_config = function()
            --     ui.close()
            -- end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --     ui.close()
            -- end
        end,
    },
}
