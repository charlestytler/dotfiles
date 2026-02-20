local minty_colorpicker = {
  "nvzone/minty",
  cmd = { "Shades", "Huefy" },
  opts = {},
}

-- Show colors for RGB/HEX codes
local colorizer = {
  "norcalli/nvim-colorizer.lua",
  event = "BufReadPre",
  cmd = { "ColorizerToggle" },
  opts = {},
  keys = {
    {
      "<leader>uc",
      "<cmd>ColorizerToggle<cr>",
      desc = "Color 🎨RGB/HEX: Toggle",
    },
  },
}

local ccc = {
  "uga-rosa/ccc.nvim",
  opts = {
    highlighter = {
      auto_enable = false,
      lsp = true,
    },
  },
  cmd = { "CccPick" },
  keys = {
    {
      "<leader>cc",
      "<cmd>CccPick<cr>",
      desc = "Color Picker 🎨",
    },
  },
}

return {
  -- minty_colorpicker,
  colorizer,
  ccc,
}
