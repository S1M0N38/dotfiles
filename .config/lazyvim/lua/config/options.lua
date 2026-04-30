-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.ttimeout = true
vim.o.ttimeoutlen = 10

-- Disable copy to system clipboard. See keymaps
vim.opt.clipboard = ""

-- Language
vim.opt.spelllang = { "en", "it" }

-- LazyVim
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazygit_config = true

-- Remove ai suggestion from completion menu
vim.g.ai_cmp = false

-- Disable Next Edit Suggestions (NES)
vim.g.sidekick_nes = false
