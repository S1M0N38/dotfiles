return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { section = "keys", gap = 1, padding = 1 },
      },
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        -- header = "",
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ':lua Snacks.dashboard.pick("files", {cwd = vim.fn.expand("$XDG_CONFIG_HOME"), hidden = true})',
            -- NOTE: open XDG_CONFIG_HOME instead of Lazyvim Config
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    terminal = {
      win = {
        wo = {
          winbar = "",
        },
      },
    },
  },

  keys = {
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.expand("$XDG_CONFIG_HOME") })
      end,
      desc = "Find Config File",
    },
  },
}
