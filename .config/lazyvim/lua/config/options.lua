-- Disable copy to system clipboard. See keymaps
vim.opt.clipboard = ""

-- VimTex
vim.g.tex_flavor = "latex"
vim.g.vimtex_compiler_latexmk = { aux_dir = "aux" }

-- Python
vim.g.python_host_prog = vim.fn.expand("$XDG_DATA_HOME") .. "/lazyvim/.venv/bin/python"
vim.g.python3_host_prog = vim.fn.expand("$XDG_DATA_HOME") .. "/lazyvim/.venv/bin/python"

-- Language
vim.opt.spelllang = { "en", "it" }

-- LazyVim
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazygit_config = true

-- Toggle Lazyvim animations
vim.g.snacks_animate = false

-- Cursor shape (set to beam in terminal mode)
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"
