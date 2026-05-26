vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.pack.add({
    -- GO plugins
    "https://github.com/ray-x/go.nvim",
    "https://github.com/ray-x/guihua.lua",

    -- LSP linters and formatters
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/pearofducks/ansible-vim",
    "https://github.com/stevearc/conform.nvim", --formatter

    -- Search files and text
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",

    -- filesystem navigation with vim keys and operations
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/stevearc/oil.nvim",

    "https://github.com/nvim-mini/mini.nvim", -- mini modules for everything

    "https://github.com/nvim-treesitter/nvim-treesitter", -- treesitter stuffj

    "https://github.com/rafamadriz/friendly-snippets", -- useful snippets library
})
