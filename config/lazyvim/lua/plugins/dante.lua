return {
  {
    "dante.nvim",
    dir = "~/Developer/dante.nvim",
    -- cmd = "Dante",
    lazy = false,
    opts = {
      presets = {
        ["default"] = {
          client = {
            base_url = "https://api.groq.com/openai/v1",
            api_key = vim.fn.getenv("GROQ_API_KEY_DANTE_NVIM"),
          },
          request = {
            model = "llama3-70b-8192",
          },
        },
        ["vimdoc"] = {
          client = {
            base_url = "https://api.groq.com/openai/v1",
            api_key = vim.fn.getenv("GROQ_API_KEY_DANTE_NVIM"),
          },
          request = {
            model = "llama3-70b-8192",
            temperature = 1.0,
            stream = false,
            messages = {
              {
                role = "system",
                content = [[
The user is writing the documentation for a vim plugin.
The text is written in vim help file syntax.

You are an assistant responsible for correcting errors in text.

- Refine the spelling and grammar while closely adhering to the original version.
- Keep the line length to 78 characters or less.
- Use the same format and style as the original text.
- Maintain the integrity of the original text's line breaks and spacing.

Return ONLY the enhanced text without commentary.
Do NOT return the generated text enclosed in triple ticks (```).
]],
              },
              {
                role = "user",
                content = "{{'<,'>}}",
              },
            },
          },
        },

        ["readme"] = {
          client = {
            base_url = "https://api.groq.com/openai/v1",
            -- base_url = "http://localhost:8008/v1",
            api_key = vim.fn.getenv("GROQ_API_KEY_DANTE_NVIM"),
          },
          request = {
            model = "llama3-70b-8192",
            -- model = "mixtral-8x7b-32768",
            temperature = 1.0,
            -- stream = true,
            messages = {
              {
                role = "system",
                content = [[
The user is writing a README for a GitHub repository.
The text is written in Markdown syntax.

You are an assistant responsible for correcting errors in text.

- Refine the spelling and grammar while closely adhering to the original version.
- Use the same format and style as the original text.
- Maintain the integrity of the original text's line breaks and spacing.

Return ONLY the enhanced text without commentary.
Do NOT return the generated text enclosed in triple ticks (```).
]],
              },
              {
                role = "user",
                content = "{{'<,'>}}",
              },
            },
          },
        },
      },
    },

    dependencies = {
      -- This is required
      { "ai.nvim", dir = "~/Developer/ai.nvim" },

      -- Not required but it improve upon built-in diff view with char diff
      {
        "rickhowe/diffchar.vim",
        keys = {
          { "[z", "<Plug>JumpDiffCharPrevStart", desc = "Previous diff", silent = true },
          { "]z", "<Plug>JumpDiffCharNextStart", desc = "Next diff", silent = true },
          {
            "do",
            "<Plug>GetDiffCharPair | <Plug>JumpDiffCharNextStart",
            desc = "Obtain diff and Next diff",
            silent = true,
          },
          {
            "dp",
            "<Plug>PutDiffCharPair | <Plug>JumpDiffCharNextStart",
            desc = "Put diff and Next diff",
            silent = true,
          },
        },
      },
    },
  },
}
