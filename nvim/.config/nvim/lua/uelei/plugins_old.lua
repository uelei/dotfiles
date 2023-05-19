local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

opts = {}

plugins = {
        "folke/which-key.nvim",
        {
                "nvim-treesitter/nvim-treesitter",
                version = false, -- last release is way too old and doesn't work on Windows
                build = ":TSUpdate",
                event = { "BufReadPost", "BufNewFile" }
        },

        {
                "williamboman/mason.nvim",
                build = ":MasonUpdate" -- :MasonUpdate updates registry contents
        },

        -- file explore
        {
                "nvim-tree/nvim-tree.lua",
                version = "*",
                dependencies = {
                        "nvim-tree/nvim-web-devicons",
                },
                config = function()
                        require("nvim-tree").setup {}
                end,
        },
}


require("lazy").setup(plugins, opts)
