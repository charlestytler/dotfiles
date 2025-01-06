return {
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  -- {
  --   "echasnovski/mini.animate",
  --   version = false,
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "echasnovski/mini.diff",
    version = false,
    event = "VeryLazy",
    opts = {
      view = {
        style = "sign",
      },
    },
    keys = {
      { "<leader>go", "<cmd>lua MiniDiff.toggle_overlay()<cr>", desc = "Diff Overlay" },
    },
  },
  {
    "echasnovski/mini.icons",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.jump",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        repeat_jump = "'", -- note: overrides marks keymap
      },
    },
  },
  {
    "echasnovski/mini.operators",
    version = false,
    event = "VeryLazy",
    opts = {
      -- stylua: ignore start
      evaluate = { prefix = ";=",
        -- Function which does the evaluation
        func = nil, },
      -- Exchange text regions
      exchange = { prefix = ";x",
        -- Whether to reindent new text to match previous indent
        reindent_linewise = true, },

      -- Multiply (duplicate) text
      multiply = { prefix = ";m",
        -- Function which can modify text before multiplying
        func = nil, },

      -- Replace text with register
      replace = { prefix = ";r",
        -- Whether to reindent new text to match previous indent
        reindent_linewise = true, },

      -- Sort text
      sort = { prefix = ";s",
        -- Function which does the sort
        func = nil, },
      -- stylua: ignore start
    },
  },
  -- {
  --   "echasnovski/mini.surround",
  --   version = false,
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
