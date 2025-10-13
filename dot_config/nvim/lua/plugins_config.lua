-- Lua line
require("lualine").setup({
    options = {
        theme = "eldritch",
        sections = {
            lualine_w = { "lsp_status" },
        },
    },
})

-- Theme
require("eldritch").setup({
    transparent = true,
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
    },
})

-- Tool management
require("mason").setup()

-- LSP
local lsp = vim.lsp

local servers = { "bashls", "ansiblels", "pyright" }

for _, server in ipairs(servers) do
    lsp.config(server, {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {},
    })
    lsp.enable(server)
end

--  Autocompletion (nvim-cmp + blink)
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
    },
    experimental = { ghost_text = true },
})

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

-- Autopair
-- Surround
require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
})
