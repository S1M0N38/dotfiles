return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      on_colors = function(colors)
        colors.border = colors.fg
      end,
    },
  },
}
