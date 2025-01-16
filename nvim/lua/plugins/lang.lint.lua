local linters = {
  "eslint_d",
  "shellcheck",
}

local nvim_lint = {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "rshkarin/mason-nvim-lint",
  },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      bash = { "shellcheck" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cl", function()
      -- Repo specific lint fix commands
      if vim.fn.getcwd():match "calendar" then
        vim.cmd "!npm run llint:fix %"
      else
        print "No lint fix command for this repo"
      end
    end, { desc = "Lint current file" })
  end,
}

local mason_nvim_lint = {
  "rshkarin/mason-nvim-lint",
  -- Ensure plugin install order: mason, mason-nvim-lint, nvim-lint
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    ensure_installed = linters,
  },
}

return {
  mason_nvim_lint,
  nvim_lint,
}
