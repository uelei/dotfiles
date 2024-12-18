return {
    { -- Fuzzy Finder (files, lsp, etc)
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { -- If encountering errors, see telescope-fzf-native README for install instructions
                'nvim-telescope/telescope-fzf-native.nvim',

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = 'make',

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            -- Useful for getting pretty icons, but requires special font.
            --  If you already have a Nerd Font, or terminal set up with fallback fonts
            --  you can enable this
            -- { 'nvim-tree/nvim-web-devicons' }
        },
        config = function()
            -- Telescope is a fuzzy finder that comes with a lot of different things that
            -- it can fuzzy find! It's more than just a "file finder", it can search
            -- many different aspects of Neovim, your workspace, LSP, and more!
            --
            -- The easiest way to use telescope, is to start by doing something like:
            --  :Telescope help_tags
            --
            -- After running this command, a window will open up and you're able to
            -- type in the prompt window. You'll see a list of help_tags options and
            -- a corresponding preview of the help.
            --
            -- Two important keymaps to use while in telescope are:
            --  - Insert mode: <c-/>
            --  - Normal mode: ?
            --
            -- This opens a window that shows you all of the keymaps for the current
            -- telescope picker. This is really useful to discover what Telescope can
            -- do as well as how to actually do it!

            -- [[ Configure Telescope ]]
            -- See `:help telescope` and `:help telescope.setup()`
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                    hidden = true,
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable telescope extensions, if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'

            local wk = require 'which-key'
            wk.add {

                { '<leader>s',        group = '+Search' },
                { '<leader>sh',       builtin.help_tags,   desc = '[S]earch [H]elp' },
                { '<leader>sk',       builtin.keymaps,     desc = '[S]earch [K]eymaps' },
                { '<leader>sf',       builtin.find_files,  desc = '[S]earch [F]iles' },
                { '<leader>ss',       builtin.builtin,     desc = '[S]earch [S]elect Telescope' },
                { '<leader>sw',       builtin.grep_string, desc = '[S]earch current [W]ord' },
                { '<leader>sg',       builtin.live_grep,   desc = '[S]earch by [G]rep' },
                { '<leader>sd',       builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
                { '<leader>sr',       builtin.resume,      desc = '[S]earch [R]esume' },
                { '<leader>s.',       builtin.oldfiles,    desc = '[S]earch Recent Files ("." for repeat)' },
                { '<leader><leader>', builtin.buffers,     desc = '[ ] Find existing buffers' },
                { '<leader>sb',       builtin.buffers,     desc = '[Search] buffers' },
                -- Slightly advanced example of overriding default behavior and theme

                {
                    '<leader>/',
                    function()
                        -- You can pass additional configuration to telescope to change theme, layout, etc.
                        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                            winblend = 10,
                            previewer = false,
                        })
                    end,
                    desc = '[/] Fuzzily search in current buffer',
                },

                -- Also possible to pass additional configuration options.
                --  See `:help telescope.builtin.live_grep()` for information about particular keys
                {
                    '<leader>s/',
                    function()
                        builtin.live_grep {
                            grep_open_files = true,
                            prompt_title = 'Live Grep in Open Files',
                        }
                    end,
                    desc = '[S]earch [/] in Open Files',
                },

                -- Shortcut for searching your neovim configuration files
                {
                    '<leader>sn',
                    function()
                        builtin.find_files { cwd = vim.fn.stdpath 'config' }
                    end,
                    desc = '[S]earch [N]eovim files',
                },
            }

            vim.keymap.set('n', '<space>ff', require('telescope.builtin').find_files)
            vim.keymap.set('n', '<leader>gC', '<cmd>Telescope git_bcommits<cr>',
                { desc = 'Checkout commit(for current file)' })
            vim.keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<cr>', { desc = 'Checkout branch' })
            vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<cr>', { desc = 'Checkout commit' })
            vim.keymap.set('n', '<leader>go', '<cmd>Telescope git_status<cr>', { desc = 'Open changed file' })
        end,
    },
}
