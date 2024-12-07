-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.ui = {
  cmp = {
    style = "default",
  },
  tabufline = {
    enabled = false,
  },
  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
  },
}

M.base46 = {
  theme = "palenight",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

return M
