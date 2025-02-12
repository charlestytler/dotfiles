return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function() -- This is the function that runs, AFTER loading
    require("which-key").setup {
      preset = "helix",
      triggers = {
        { "<auto>", mode = "nxsotc" },
        { "s", mode = { "n", "v" } },
      },
    }

    -- Document existing key chains
    require("which-key").add {
      { ";a", group = "[A]lign", mode = { "x" } },
      { "<leader>a", group = "[A]i 🤖" },
      { "<leader>c", group = "[C]ode </>" },
      { "<leader>d", group = "[D]iff 🚧" },
      { "<leader>f", group = "[F]iles 📂" },
      { "<leader>l", group = "[L]og 🪵" },
      { "<leader>q", group = "[Q]uickfix 🔧" },
      { "<leader>r", group = "[R]eplace 🔁" },
      { "<leader>s", group = "[S]earch 🔍" },
      { "<leader>t", group = "[T]est 🧪" },
      { "<leader>w", group = "[W]indow 🪟" },
      { "<leader>u", group = "[U]I 🎨" },
      { "<leader>g", group = "[G]it 󰊢", mode = { "n", "v" } },
      { "<leader>gh", group = "[H]unk ⇄", mode = { "n", "v" } },
      { "<leader>cw", group = "[W]orkspace 💼", mode = { "n", "v" } },
    }
  end,
}
