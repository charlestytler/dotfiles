local ensure_installed_servers = {
  "lua_ls",
  "html",
  "cssls",
  "clangd",
  "ts_ls",
  "bashls",
  "basedpyright",
  "neocmake",
}

local mason_lspconfig = {
  "mason-org/mason-lspconfig.nvim",
  -- Ensure plugins are loaded in order: mason, mason-lspconfig, nvim-lspconfig
  opts = {
    ensure_installed = ensure_installed_servers,
  },
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
}

return {
  mason_lspconfig,
}
