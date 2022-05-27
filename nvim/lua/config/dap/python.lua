local M = {}

function M.setup(_)
  -- require("dap-python").setup("python", {})

  local dap = require('dap')
  local venv = os.getenv("VIRTUAL_ENV")

  dap.adapters.python = {
      type = 'executable';
      command = string.format("%s/bin/python",venv),
      args = { '-m', 'debugpy.adapter' };
  }

  vim.notify("DAP loading vscode python")

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      local venv = os.getenv("VIRTUAL_ENV")
      if not venv then
          vim.notify("No virtual environment")
      end
      return string.format("%s/bin/python", venv)
    end;
  },
}
  
end

return M
