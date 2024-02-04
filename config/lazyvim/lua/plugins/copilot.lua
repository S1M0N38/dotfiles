return {
  "zbirenbaum/copilot.lua",
  keys = {
    {
      "<leader>cc",
      function()
        local Util = require("lazy.core.util")
        vim.g.copilot_disable = not vim.g.copilot_disable
        if vim.g.copilot_disable then
          Util.warn("Disabled Copilot", { title = "Option" })
          require("copilot.command").disable()
        else
          Util.info("Enabled Copilot", { title = "Option" })
          require("copilot.command").enable()
        end
      end,
      desc = "Toggle Copilot",
    },
  },
}
