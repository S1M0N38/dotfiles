return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = false,
          autoSearchPaths = false,
        },
      },
    },
  },
}
