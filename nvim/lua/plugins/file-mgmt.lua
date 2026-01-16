local buffer_manager = {
  "j-morano/buffer_manager.nvim",
  event = "BufEnter",
  opts = {},
  keys = {
    { "<leader>b", "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>", desc = "Buffer Manager" },
    { "(", "<cmd>lua require('buffer_manager.ui').nav_prev()<CR>", desc = "Buffer Prev" },
    { ")", "<cmd>lua require('buffer_manager.ui').nav_next()<CR>", desc = "Buffer Next" },
  },
}

local harpoon = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  opts = {
    global_settings = {
      -- mark_branch = true,
      -- tabline = true,
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>`", function() require("harpoon"):list():add() end, desc = "harpoon file", },
    { "<leader>h", function() local harpoon = require "harpoon" harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon quick menu", },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
    -- stylua: ignore end
  },
}

local oil = {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["<leader>?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<M-l>"] = { "actions.select", opts = { vertical = true } },
      ["<M-j>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-h>"] = false,
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["<C-5>"] = "actions.refresh",
      ["<C-l>"] = false,
      ["<BS>"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    view_options = {
      show_hidden = true,
    },
  },
  cmd = { "Oil" },
  -- Optional dependencies
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  keys = {
    { "<leader>o", "<cmd>Oil<cr>", desc = "Open oil" },
  },
}

return {
  buffer_manager,
  harpoon,
  oil,
}
