local formatters = {
  "black",
  "clang-format",
  "prettier",
  "shfmt",
  "stylua",
  "gersemi", -- cmake formatter
}

local conform = {
  "stevearc/conform.nvim",
  event = "BufWritePre", -- uncomment for format on save
  dependencies = {
    "zapling/mason-conform.nvim",
  },
  opts = {
    formatters_by_ft = {
      sh = { "shfmt" },
      cmake = { "gersemi" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      python = { "black" },
      scss = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
    },

    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 5000,
      lsp_fallback = true,
    },
  },
}

local mason_conform = {
  "zapling/mason-conform.nvim",
  dependencies = {
    "mason-org/mason.nvim",
  },
  opts = {
    formatters = formatters,
  },
}

return {
  mason_conform,
  conform,
}
