-- Lua line
require("lualine").setup({
    options = { theme = "eldritch" },
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

-- Autocomplete
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    --event = "InsertEnter",
    completion = {
        completeopt = "menu,menuone",
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- sources for autocompletion
    sources = cmp.config.sources({
        { name = "luasnip" }, -- snippets
        { name = "nvim_lsp" },
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
    }),
    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
        }),
    },
})

-- LSP
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").pyright.setup({
    capabilities = capabilities,
})
require("lspconfig").bashls.setup({
    capabilities = capabilities,
})
require("lspconfig").ansiblels.setup({
    capabilities = capabilities,
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

-- nvim-treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" },
    highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nill,
    },
})

-- Autopair
-- Surround
require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
})
