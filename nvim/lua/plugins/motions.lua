local leap = {
  "ggandor/leap.nvim",
  config = function()
    local leap = require "leap"
    leap.opts.case_sensitive = true
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
    -- vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
  end,
  lazy = false,
}

local flash = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    hightlight = {
      backdrop = false,
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = true,
        keys = { "f", "F", "t", "T", [";"] = "," }, -- default { "f", "F", "t", "T", ";", "," },
        autohide = true,
        jump_labels = false,
        hightlight = { backdrop = false },
      },
    },
  },
    -- stylua: ignore
    keys = {
      { ";s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { ";v", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
}

local quickscope = {
  "unblevable/quick-scope",
  event = "BufEnter",
  config = function()
    vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    vim.keymap.set({ "n" }, "<leader>uq", "<cmd>QuickScopeToggle<CR>", { desc = "Quickscope Toggle" })
  end,
}

return {
  leap,
  flash,
  quickscope,
}
