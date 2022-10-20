
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- not store deleted line on register
keymap("v", "dd", '"_dd', opts)
keymap("n", "dd", '"_dd', opts)

keymap("v", "x", '"_x', opts)
keymap("n", "x", '"_x', opts)

