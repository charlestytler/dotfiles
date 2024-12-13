return {
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.animate",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
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
  -- {
  --   "echasnovski/mini.operators",
  --   version = false,
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
}
