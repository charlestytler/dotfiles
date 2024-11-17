return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "s", mode = { "n", "v" } },
    },
  },
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup()

    -- Document existing key chains
    require("which-key").add {
      { "<leader>c", group = "[C]ode" },
      -- { "<leader>d", group = "[D]ocument" },
      { "<leader>f", group = "[F]ind 🔍" },
      { "<leader>r", group = "[R]eplace" },
      { "<leader>s", group = "[S]earch" },
      { "<leader>w", group = "[W]indow" },
      { "<leader>u", group = "[U]I" },
      { "<leader>g", group = "[G]it", mode = { "n", "v" } },
      { "<leader>gh", group = "[H]unk", mode = { "n", "v" } },
      { "<leader>cw", group = "[W]orkspace", mode = { "n", "v" } },
    }
  end,
}
