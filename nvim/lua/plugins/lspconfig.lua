return {
  "neovim/nvim-lspconfig",
  config = function()
    require "lsp_config.config"
  end,
  dependencies = {
    "antosha417/nvim-lsp-file-operations",
  },
}
