local minty_colorpicker = {
  "nvzone/minty",
  cmd = { "Shades", "Huefy" },
  opts = {},
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
  ccc,
}
