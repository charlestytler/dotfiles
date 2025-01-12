local undotree = {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_WindowLayout = 3
      vim.keymap.set("n", "<leader><C-u>", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
    end,
  },
}

local persistence = {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  },
}

return {
  undotree,
  persistence,
}
