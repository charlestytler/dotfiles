-- {
--   "echasnovski/mini.jump",
--   version = false,
--   event = "VeryLazy",
--   opts = {
--     mappings = {
--       repeat_jump = "'", -- note: overrides marks keymap
--     },
--   },
-- },

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
        enabled = false,
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
  init = function()
    vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
  end,
  config = function()
    vim.keymap.set({ "n" }, "<leader>uq", "<cmd>QuickScopeToggle<CR>", { desc = "Quickscope Toggle" })
    vim.keymap.set({ "n" }, ",", ";", { desc = "Repeat f,F,t,T" })
  end,
}

local nvim_spider = {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      ";w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase w",
    },
    {
      ";e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase e",
    },
    {
      ";b",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase b",
    },
    -- Punctuation skipping option off
    {
      ";W",
      "<cmd>lua require('spider').motion('w', {skipInsignificantPunctuation = false})<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase w (noskip punct.)",
    },
  },
}

local treewalker = {
  "aaronik/treewalker.nvim",

  -- The following options are the defaults.
  -- Treewalker aims for sane defaults, so these are each individually optional,
  -- and setup() does not need to be called, so the whole opts block is optional as well.
  opts = {
    -- Whether to briefly highlight the node after jumping to it
    highlight = true,

    -- How long should above highlight last (in ms)
    highlight_duration = 250,

    -- The color of the above highlight. Must be a valid vim highlight group.
    -- (see :h highlight-group for options)
    highlight_group = "CursorLine",
  },
  keys = {
    { "<C-S-k>", mode = { "n", "v" }, "<cmd>Treewalker Up<cr>", desc = "Treewalker Up", { silent = true } },
    { "<C-S-j>", mode = { "n", "v" }, "<cmd>Treewalker Down<cr>", desc = "Treewalker Down", { silent = true } },
    { "<C-S-h>", mode = { "n", "v" }, "<cmd>Treewalker Left<cr>", desc = "Treewalker Left", { silent = true } },
    { "<C-S-l>", mode = { "n", "v" }, "<cmd>Treewalker Right<cr>", desc = "Treewalker Right", { silent = true } },
  },
}

return {
  leap,
  flash,
  quickscope,
  nvim_spider,
  treewalker,
}
