vim.g.mapleader = " "

local opt = vim.opt

-- UI
opt.laststatus = 3 -- global statusline
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.termguicolors = true -- True color support

-- Search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals

-- Indent
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically
opt.foldmethod = "indent"

-- Splits
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

-- Completions
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.completeopt = "menu,menuone,noselect"

-- Others
opt.smoothscroll = true
opt.undofile = true
opt.spelllang = { "en", "it" }
