require("which-key").add({
  { "<leader>a", group = "ai", icon = "" },
  { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude", icon = "󰭻" },
  { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude", icon = "" },
  { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude", icon = "" },
  { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude", icon = "" },
  { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer", icon = "" },
  { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude", icon = "" },
  -- TODO: activate after PR merged
  -- {
  --   "<leader>as",
  --   "<cmd>ClaudeCodeTreeAdd<cr>",
  --   desc = "Add file",
  --   icon = "",
  --   ft = { "NvimTree", "neo-tree", "oil" },
  -- },
  { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff", icon = "-" },
  { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff", icon = "+" },
})

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  lazy = false,
  config = true,
  keys = {},
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
      provider = "snacks",
      auto_close = true,
    },
  },
}
