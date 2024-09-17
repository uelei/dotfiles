local wk = require 'which-key'

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- -- Keymaps for better default experience
-- -- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
--
-- -- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

wk.add {
  -- Buffer
  { '<leader>b', group = 'Buffer', icon = '' },
  { '<leader>bc', '<cmd>bdelete<cr>', desc = 'Close' },
  { '<leader>bt', '<cmd>terminal<cr>', desc = 'Terminal' },
  -- File
  { '<leader>f', group = 'File', icon = '' },
  { '<leader>fa', '<cmd>%y<cr>', desc = 'Buffer contents' },
  { '<leader>ff', "<cmd>let @+ = expand('%:p')<cr> <cmd>lua vim.notify('Yanked full path')<cr>", desc = 'Full Path' },
  { '<leader>fn', '<cmd>new<cr>', desc = 'New File' },
  { '<leader>fp', "<cmd>let @+ = expand('%:~:.')<cr> <cmd>lua vim.notify('Yanked relative path')<cr>", desc = 'Relative Path' },
  -- Git
  { '<leader>g', group = 'Git' },
  { '<leader>gC', '<cmd>Telescope git_bcommits<cr>', desc = 'Checkout commit(for current file)' },
  { '<leader>gL', '<cmd>GitBlameToggle<cr>', desc = 'Blame all' },
  { '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = 'Reset Buffer' },
  { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'Checkout branch' },
  { '<leader>gc', '<cmd>Telescope git_commits<cr>', desc = 'Checkout commit' },
  { '<leader>gd', '<cmd>Gitsigns diffthis HEAD<cr>', desc = 'Git Diff' },
  { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazygit' },
  { '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = 'Next Hunk' },
  { '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = 'Prev Hunk' },
  { '<leader>gl', "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = 'Blame' },
  { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' },
  { '<leader>go', '<cmd>Telescope git_status<cr>', desc = 'Open changed file' },
  { '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = 'Preview Hunk' },
  { '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = 'Reset Hunk' },
  { '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = 'Stage Hunk' },
  { '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = 'Undo Stage Hunk' },
  -- LSP
  { '<leader>l', group = '+Lsp', icon = '' },

  -- windows
  { '<leader>w', group = '+Window', icon = '' },
  { '<leader>ww', '<C-W>p', desc = 'Other window', remap = true },
  { '<leader>wd', '<C-W>c', desc = 'Delete window', remap = true },
  { '<leader>w-', '<C-W>s', desc = 'Split window below', remap = true },
  { '<leader>w|', '<C-W>v', desc = 'Split window right', remap = true },
  { '<leader>-', '<C-W>s', desc = 'Split window below', remap = true },
  { '<leader>|', '<C-W>v', desc = 'Split window right', remap = true },

  { '<leader>dP', group = '+Python' },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>we', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>wq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- vim.diagnostic.config({
--   virtual_text = {
--     -- source = "always",  -- Or "if_many"
--     prefix = '●', -- Could be '■', '▎', 'x'
--   },
--   severity_sort = true,
--   float = {
--     source = "always",  -- Or "if_many"
--   },
-- })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
-- without tmux
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- better up/down
-- map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
local nvim_tmux_nav = require 'nvim-tmux-navigation'
nvim_tmux_nav.setup {
  disable_when_zoomed = true, -- defaults to false
}

map('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = 'Go to left window', remap = true })
map('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown, { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, { desc = 'Go to right window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move Lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- buffers
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
map('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
map('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })

map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- -- Clear search, diff update and redraw
-- -- taken from runtime/lua/_editor.lua
-- map(
--     "n",
--     "<leader>ur",
--     "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--     { desc = "Redraw / clear hlsearch / diff update" }
-- )

map({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- lazy
map('n', '<leader>sL', '<cmd>:Lazy<cr>', { desc = 'Lazy' })
map('n', '<leader>sM', '<cmd>:Mason<cr>', { desc = 'Mason' })

-- map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- if not Util.has("trouble.nvim") then
--   map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
--   map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
-- end

-- quit
map('n', '<leader>q', '<cmd>qa<cr>', { desc = 'Quit all' })

map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })

-- -- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
--
-- wk.register({
--     ["<leader><tab>"] = { name = "+Tab" },
-- })

-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '<C-_>', function()
  require('Comment.api').toggle.linewise.current()
end, { noremap = true, silent = true })

vim.keymap.set('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
