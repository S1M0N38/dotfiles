require("config.options")
require("config.keymaps")
require("config.autocmds")
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
})
