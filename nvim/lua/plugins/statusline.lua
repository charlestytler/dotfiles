local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local filetypeIcon = {
  "filetype",
  colored = true,
  icon_only = true,
  separator = "",
  padding = { left = 1, right = 0 },
}

local workspaceDir = {
  function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end,
  icon = "", -- Optional: folder icon
  color = {},
}

local lualine = {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "catppuccin",
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "|" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { filetypeIcon, { "filename", padding = { left = 0, right = 1 } } },
      lualine_c = { "branch", "diff", "diagnostics", "searchcount" },
      lualine_x = { "filetype", "lsp_status" },
      lualine_y = { "progress", { "location", padding = { left = 0, right = 1 } } },
      lualine_z = { workspaceDir },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = { workspaceDir },
    },
    extensions = { "quickfix", "oil" },
  },
}

return {
  lualine,
}
