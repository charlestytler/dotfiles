return {
  {
    "github/copilot.vim",
    cmds = {
      "Copilot",
    },
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = function() -- This is the function that runs, AFTER loading
      require("codecompanion").setup {
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
        },
      }
    end,
    keys = {
      { "<leader>a", "<cmd>CodeCompanionChat<CR>", desc = "AI chat" },
    },
  },

  {
    "Exafunction/codeium.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    -- keys = {
    --   { "<leader>a", "<cmd>Codeium Chat<CR>", desc = "Ask Codeium chat" },
    -- },
    opts = {
      enable_cmp_source = true,
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = "<Tab>",
          accept_word = ";<Tab>",
          clear = "jl",
        },
      },
    },
  },
}
