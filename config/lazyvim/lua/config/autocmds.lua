local function augroup(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Sync with server on save (only if the sync script exists)

vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("sync_with_server"),
  callback = function()
    local path = vim.fn.getcwd() .. "/scripts/sync.sh"
    local file = io.open(path, "r")
    if file ~= nil and io.close(file) then
      vim.fn.jobstart("SIMPLE=1 bash " .. path .. " --upload", {
        on_stdout = function(_, data, _)
          local message = table.concat(data, "\n", 2, #data - 1)
          vim.notify("Uploaded\n" .. message, vim.log.levels.INFO)
        end,
        on_exit = function(_, code, _)
          if code == 0 then
          elseif code == 225 then
            vim.notify("Unable to connect to the server", vim.log.levels.ERROR)
          elseif code == 23 then
            vim.notify("Wrong filename in upload.txt", vim.log.levels.ERROR)
          else
            vim.notify("Unknown error code", vim.log.levels.ERROR)
            print(code)
          end
        end,
        stdout_buffered = true,
      })
    end
  end,
})

-- Compile single C file on save

vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("compile_c"),
  pattern = "*.c",
  callback = function()
    local cmd = "gcc " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r")
    vim.fn.jobstart(cmd, {
      on_exit = function(_, code, _)
        if code == 0 then
          vim.notify("Compiled", vim.log.levels.INFO)
        else
          vim.notify("Compilation failed", vim.log.levels.ERROR)
        end
      end,
    })
  end,
})

-- Setup Alacritty colorscheme from Neovim

local function set_alacritty_colorscheme(name)
  -- The name of the alachritty colorscheme palce in the theme directory
  -- must be the same as the name of the colorscheme in Neovim
  local config_dir = vim.fn.expand("$XDG_CONFIG_HOME/alacritty")
  local config = config_dir .. "/alacritty.toml"
  local source = config_dir .. "/themes/" .. name .. ".toml"
  local dest = config_dir .. "/colorscheme.toml"
  local cmd = "ln -sf " .. source .. " " .. dest .. " && touch " .. config

  vim.fn.jobstart(cmd, {
    on_exit = function(_, code, _)
      if code ~= 0 then
        vim.notify("Failed to set Alacritty color scheme", vim.log.levels.ERROR)
      end
    end,
  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("alacritty_colorscheme"),
  callback = function(args)
    set_alacritty_colorscheme(args.match)
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = augroup("alacritty_colorscheme_cyberdream"),
  pattern = "CyberdreamToggleMode",
  callback = function(event)
    if event.data == "default" then
      set_alacritty_colorscheme("cyberdream")
    else
      set_alacritty_colorscheme("cyberdream-light")
    end
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  group = augroup("alacritty_colorscheme_gruvbox"),
  callback = function()
    local background = vim.api.nvim_get_option_value("background", { scope = "global" })
    if vim.g.colors_name == "gruvbox" then
      if background == "dark" then
        set_alacritty_colorscheme("gruvbox")
      else
        set_alacritty_colorscheme("gruvbox-light")
      end
    end
    if vim.g.colors_name == "solarized" then
      if background == "dark" then
        set_alacritty_colorscheme("solarized")
      else
        set_alacritty_colorscheme("solarized-light")
      end
    end
  end,
})

-- Python Config
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  group = augroup("ft_python"),
  callback = function()
    vim.cmd("set colorcolumn=89")
  end,
})
