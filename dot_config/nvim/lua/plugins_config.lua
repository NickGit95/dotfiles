-- Tool management
require("mason").setup()

-- LSP
local lsp = vim.lsp

local servers = { "bashls", "ansiblels", "pyright", "gopls", "lua_ls" }

for _, server in ipairs(servers) do
    lsp.enable(server)
end

-- Linters
require("lint").linters_by_ft = {
    sh = { "shellcheck" },
    python = { "pylint" },
    ansible = { "ansible_lint" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufReadPost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

-- Formatters
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        ["_"] = { "trim_whitespace" },
    },
    formatters = {
        shfmt = {
            prepend_args = { "-i", "4", "--simplify" },
        },
        stylua = {
            prepend_args = { "--indent-type", "Spaces" },
        },
        yamlfmt = {
            prepend_args = { "-formatter", "indent=2,include_document_start=true,retain_line_breaks_single=true" },
        },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
    },
})

-- Oil
require("oil").setup()

-- Telescope
require("telescope").setup()

--Go
require("go").setup()
-- Run gofmt on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require("go.format").gofmt()
    end,
    group = format_sync_grp,
})
