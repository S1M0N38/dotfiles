local map = vim.keymap.set

-- Improved yank/paste/delete
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting the default register" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without overwriting the default register" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank to system clipboard" })

-- better "J" (keep cursor in place)
map("n", "J", "mzJ`z")

-- Toggle linebreak
map("n", "<leader>uW", "<cmd>set linebreak!<cr>", { desc = "Toggle Line Break" })
