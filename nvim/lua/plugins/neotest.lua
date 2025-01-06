return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Nearest" },
    {
      "<leader>tf",
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
      desc = "Run Neotest for current file",
    },
    {
      "<leader>td",
      "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
      desc = "Debug Neotest for current file",
    },
    { "<leader>to", "<cmd>lua require('neotest').output.open()<cr>", desc = "Open Output" },
    { "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary Toggle" },
    { "<leader>th", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Halt Test" },
    {
      "<leader>tw",
      "<cmd>lua require('neotest').run.run({ jestCommand = 'npm test -- --watch ' })<cr>",
      desc = "Watch Test",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-jest" {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            -- return vim.fn.getcwd()
            return vim.fn.expand "%:h"
          end,
        },
      },
    }
  end,
}
