-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("", "<Esc>", "<Esc>")

-- System clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- LSP restart
vim.keymap.set("n", "<leader>cL", "<cmd>LspRestart<cr>", { desc = "Restart LSP servers" })

-- Inspect JSONL line: open selected JSON in a new buffer and format with jq
vim.keymap.set("x", "<leader>ij", function()
  -- Yank the selection to the z register
  vim.cmd('normal! "zy')
  local json_text = vim.fn.getreg("z")

  -- Format with jq
  local result = vim.fn.system("jq .", json_text)
  local exit_code = vim.v.shell_error

  -- Create a new scratch buffer
  vim.cmd("enew")
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = "json"

  -- Set the content (formatted or original with error)
  if exit_code == 0 then
    local lines = vim.split(result, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  else
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "-- jq error: " .. result, "", json_text })
  end
end, { desc = "Inspect JSON (format with jq)" })
