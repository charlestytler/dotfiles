return {
  "nvimdev/dashboard-nvim",
  -- event = "VimEnter",
  enable = false,
  opts = {
    theme = "hyper",
    config = {
      week_header = {
        enable = true,
      },
      shortcut = {
        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
        {
          icon = " ",
          icon_hl = "@variable",
          desc = "Oil",
          group = "Label",
          action = "Oil .",
          key = "o",
        },
        {
          desc = "󰊢 Repos",
          group = "Find",
          action = "Telescope git_files",
          key = "g",
        },
        {
          desc = "󰈮 Code",
          group = "Find",
          action = "Telescope find_files search_dirs=~/code",
          key = "c",
        },
        {
          desc = " ~/dotfiles",
          group = "Number",
          action = "Telescope find_files search_dirs=~/dotfiles",
          key = "d",
        },
      },
      packages = { enable = false },
      project = { limit = 3, icon = "󰶞", label = " Recent Projects" },
      mru = { limit = 5, icon = "󰙅", label = " Recent files" },
      footer = {},
    },
  },
}
