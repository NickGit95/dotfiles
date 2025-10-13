local builtin = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope fuzzy finder
map("n", "<leader>ff", builtin.find_files, { desc = "telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "telescope grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "telescope find buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "telescope help tags" })

-- Windows
map("n", "<leader>wh", "<C-w>h", { desc = "switch window left" })
map("n", "<leader>wl", "<C-w>l", { desc = "switch window right" })
map("n", "<leader>wj", "<C-w>j", { desc = "switch window down" })
map("n", "<leader>wk", "<C-w>k", { desc = "switch window up" })
map("n", "<leader>wc", "<CMD>close<CR>", { desc = "close window" })
map("n", "<leader>ws", "<CMD>split<CR>", { desc = "split window" })
map("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "split window vertically" })

-- Oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Format & Diagnostics
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostics", unpack(opts) })
map("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Next diagnostic", unpack(opts) })
map("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Prev diagnostic", unpack(opts) })

-- Ansible
map("v", "<leader>te", function()
    require("ansible").run()
end, { buffer = true, silent = true })
map("n", "<leader>te", ":w<CR> :lua require('ansible').run()<CR>", { buffer = true, silent = true })
