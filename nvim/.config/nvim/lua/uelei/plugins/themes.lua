return {
    {
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd.colorscheme 'tokyonight-storm'
        end,
    },

    -- Themes
    'Mofiqul/dracula.nvim',

    {
        'catppuccin/nvim',
        laze = false,
        -- config = function()
        --     vim.cmd.colorscheme 'catppuccin-frappe'
        -- end,
    },
}
