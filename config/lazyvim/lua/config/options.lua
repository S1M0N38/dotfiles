-- Disable copy to system clipboard. See keymaps
vim.opt.clipboard = ""

-- Disable providers
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Language
vim.opt.spelllang = { "en", "it" }

-- VimTex
vim.g.tex_flavor = "latex"
vim.g.vimtex_compiler_latexmk = { aux_dir = "aux" }
