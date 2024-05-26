return {
  {
    "folke/zen-mode.nvim",
    opts = {},
    cmd = "ZenMode",
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1500,
      stages = "static",
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(string.rep("\n", 8), "\n"),
        footer = {},
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      messages = {
        enabled = false,
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d fewer lines" },
              { find = "%d more lines" },
              { find = "%d lines moved" },
              { find = "%d lines indented" },
              { find = "%d lines <ed %d time[s]?" },
              { find = "%d lines >ed %d time[s]?" },
              { find = "%d lines yanked" },
            },
          },
          opts = { skip = true },
        },
      },
    },
  },
}
