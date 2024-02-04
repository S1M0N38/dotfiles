-- Disable copy to system clipboard. See keymaps
vim.opt.clipboard = ""

-- Disable providers
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Enable providers
-- I've have created a virtual environment for neovim.
-- Using a python version installed with pyenv, I've created a virtual environment
-- with the following command:
-- .local/share/pyenv/versions/3.10.13/bin/python -m venv .local/share/venv/neovim
-- Then installed the neovim package with the corresponding pip:
-- ~/.local/share/venv/neovim/bin/python -m pip install pynvim
vim.g.python3_host_prog = "~/.local/share/venv/neovim/bin/python"

-- Language
vim.opt.spelllang = { "en", "it" }

-- VimTex
vim.g.tex_flavor = "latex"
vim.g.vimtex_compiler_latexmk = { aux_dir = "aux" }
