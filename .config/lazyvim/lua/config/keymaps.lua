local map = vim.keymap.set

-- Improved yank/paste/delete
map("x", "<leader>p", '"_dP', { desc = 'Paste wo overwriting "' })
map({ "v" }, "<leader>d", '"_d', { desc = 'Delete wo overwriting "' })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank to system clipboard" })

-- Additional buffer operations
map({ "n", "v" }, "<leader>by", 'mqgg"+yG`q<cmd>delm q<cr>', { desc = "Yank buffer to system clipboard" })
map("n", "<leader>bv", "ggVG", { desc = "Select all lines in buffer" })

-- better "J" (keep cursor in place)
map("n", "J", "mqJ`q<cmd>delm q<cr>")
