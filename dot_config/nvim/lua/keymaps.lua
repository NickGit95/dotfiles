-- Telescope fuzzy finder
local builtin = require("telescope.builtin")
local map = vim.keymap
map.set("n", "<leader>ff", builtin.find_files, { desc = "telescope find files" })
map.set("n", "<leader>fg", builtin.live_grep, { desc = "telescope grep" })
map.set("n", "<leader>fb", builtin.buffers, { desc = "telescope find buffers" })
map.set("n", "<leader>fh", builtin.help_tags, { desc = "telescope help tags" })

-- Windows
map.set("n", "<leader>wh", "<C-w>h", { desc = "switch window left" })
map.set("n", "<leader>wl", "<C-w>l", { desc = "switch window right" })
map.set("n", "<leader>wj", "<C-w>j", { desc = "switch window down" })
map.set("n", "<leader>wk", "<C-w>k", { desc = "switch window up" })
map.set("n", "<leader>wc", "<CMD>close<CR>", { desc = "close window" })
map.set("n", "<leader>ws", "<CMD>split<CR>", { desc = "split window" })
map.set("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "split window vertically" })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Ansible
vim.keymap.set("v", "<leader>te", function()
    require("ansible").run()
end, { buffer = true, silent = true })
vim.keymap.set("n", "<leader>te", ":w<CR> :lua require('ansible').run()<CR>", { buffer = true, silent = true })
