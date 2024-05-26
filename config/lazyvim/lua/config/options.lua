-- Setup colorscheme by using current Alacritty colorscheme
local symlink = vim.fn.expand("$XDG_CONFIG_HOME/alacritty/colorscheme.toml")
local source = vim.loop.fs_readlink(symlink)
if source then
  local colorscheme = source:match("^.+/(.+)$"):match("(.+)%..+")
  if colorscheme == "gruvbox-light" then
    vim.g.colorscheme = "gruvbox"
    vim.opt.background = "light"
  elseif colorscheme == "cyberdream-light" then
    vim.g.colorscheme = "cyberdream"
    -- TODO: add some way to set the light version of the colorscheme
  else
    vim.g.colorscheme = colorscheme
  end
else
  vim.notify("Failed to resolve symlink: " .. symlink, vim.log.levels.WARN)
  vim.g.colorscheme = "tokyonight"
end

-- Disable copy to system clipboard. See keymaps
vim.opt.clipboard = ""

-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Python
vim.g.python3_host_prog = vim.fn.expand("$XDG_DATA_HOME") .. "/venvs/neovim/bin/python"
vim.g.loaded_python_provider = vim.g.python3_host_prog
vim.g.loaded_python3_provider = vim.g.python3_host_prog

-- Language
vim.opt.spelllang = { "en", "it" }

-- VimTex
vim.g.tex_flavor = "latex"
vim.g.vimtex_compiler_latexmk = { aux_dir = "aux" }
