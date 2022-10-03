local M = {}

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- add other configs here
--
--
local venv = os.getenv("VIRTUAL_ENV")

dap.adapters.python = {
      type = 'executable';
      command = string.format("%s/bin/python",venv),
      args = { '-m', 'debugpy.adapter' };
  }

--   require("dap-python").setup(string.format("%s/bin/python",venv))
--   vim.notify("DAP loading vscode python")
--
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = function()
--       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--       local cwd = vim.fn.getcwd()
--       local venv = os.getenv("VIRTUAL_ENV")
--       if not venv then
--           vim.notify("No virtual environment")
--       end
--       return string.format("%s/bin/python", venv)
--     end;
--   },
-- }


require('dapui').setup(
  )
dapui.setup {

  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
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
  }
}

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

function M.setup()
  vim.notify("DAP initializing...")
  -- configure() -- Configuration
  -- configure_exts() -- Extensions
  -- configure_debuggers() -- Debugger
  -- require('dap.ext.vscode').load_launchjs()
  require("user.dap.keymaps").setup() -- Keymaps
end

return M
