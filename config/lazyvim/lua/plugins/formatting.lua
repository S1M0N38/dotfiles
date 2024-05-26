return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Install mdformat with
        --  `pipx install mdformat`
        -- and the add GitHub support with
        --  `pipx inject mdformat mdformat-gfm mdformat-frontmatter mdformat-footnote`
        markdown = { "mdformat" },
      },
    },
  },
}
