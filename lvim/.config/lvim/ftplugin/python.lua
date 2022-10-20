local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  C = {
    name = "Python",
    m = { "<cmd>lua require('dap-python').test_method()<cr>", "Debug Test Method" },
    c = { "<cmd>lua require('dap-python').test_class()<cr>", "Debug Test Class" },
    s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
    t = { "<cmd>TestNearest<cr>", "Test Nearest" },

  },
}

which_key.register(mappings, opts)
