-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local aug_makefile = vim.api.nvim_create_augroup("MakefileSettings", { clear = true })
local aug_cfile = vim.api.nvim_create_augroup("CSettings", { clear = true })

-- Makefile settings
vim.api.nvim_create_autocmd("FileType", {
  group = aug_makefile,
  pattern = "make",
  callback = function()
    vim.bo.expandtab = false -- Use actual tabs, not spaces
    vim.bo.tabstop = 8 -- Tab width (typical for Makefiles)
    vim.bo.shiftwidth = 8 -- Indentation width
    vim.bo.softtabstop = 0 -- Disable soft tabs
  end,
  desc = "Set tab settings for Makefiles",
})

-- C file settings
vim.api.nvim_create_autocmd("FileType", {
  group = aug_cfile,
  pattern = "c",
  callback = function()
    vim.opt_local.makeprg = "cc -O2 -W -Wall %"
  end,
  desc = "Set makeprg for C files",
})
