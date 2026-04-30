return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { section = "keys", gap = 1, padding = 1 },
      },
    },
  },
  keys = {
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.expand("$XDG_CONFIG_HOME"), hidden = true })
      end,
      desc = "Find Config File",
    },
  },
}
