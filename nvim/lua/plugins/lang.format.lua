local formatters = {
  "black",
  "prettierd",
  "stylua",
}

local conform = {
  "stevearc/conform.nvim",
  event = "BufWritePre", -- uncomment for format on save
  dependencies = {
    "zapling/mason-conform.nvim",
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      python = { "black" },
    },

    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 2000,
      lsp_fallback = true,
    },
  },
}

local mason_conform = {
  "zapling/mason-conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}

return {
  mason_conform,
  conform,
}
