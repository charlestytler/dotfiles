local gitPRs = function()
  local in_git = Snacks.git.get_root() ~= nil
  local cmds = {
    {
      icon = " ",
      title = "Git GUI",
      cmd = "echo && git tree",
      key = "g",
      action = function()
        Snacks.lazygit()
      end,
      height = 7,
    },
    {
      icon = " ",
      title = "Open PRs",
      cmd = "gh pr list -L 7",
      key = "p",
      action = function()
        vim.fn.jobstart("gh pr list --web", { detach = true })
      end,
    },
  }
  return vim.tbl_map(function(cmd)
    return vim.tbl_extend("force", {
      section = "terminal",
      enabled = in_git,
      padding = 1,
      ttl = 5 * 60,
      indent = 3,
    }, cmd)
  end, cmds)
end

local dashboardConfig = {
  enabled = true,
  width = 70,
  preset = {
    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    --      header = [[
    --                                __
    --   ___     ___    ___   __  __ /\_\    ___ ___
    --  / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
    -- /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
    -- \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
    --  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    keys = {
      { icon = " ", key = "o", desc = "[o]il (Open File Sys)", action = ":Oil ." },
      { icon = " ", key = "n", desc = "[n]ew File", action = ":ene | startinsert" },
      { icon = " ", key = "r", desc = "[r]ecent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      { icon = " ", key = "s", desc = "Git [s]how Files", action = "<leader>fs" },
      { icon = " ", key = "b", desc = "Git [b]ranch Files", action = "<leader>fb" },
      { icon = " ", key = "d", desc = "[d]otfiles", action = "<leader>fc" },
      { icon = " ", key = "S", desc = "Restore [S]ession", section = "session" },
      { icon = " ", desc = "[g]it GUI", key = "g", action = "<leader>gg" },
      { icon = "󰒲 ", key = "L", desc = "[L]azy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
      { icon = " ", key = "q", desc = "[q]uit", action = ":qa" },
    },
  },
  sections = {
    { section = "header" },
    { section = "keys", gap = 1, padding = 1 },
    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    -- gitPRs,
    {
      icon = " ",
      desc = "Browse Git [R]epo",
      padding = 1,
      key = "R",
      action = function()
        Snacks.gitbrowse()
      end,
    },
    { section = "startup" },
  },
}

local dashboard_nvim = {
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

-- see plugins/snacks.lua
return dashboardConfig
