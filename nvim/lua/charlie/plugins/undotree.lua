return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_WindowLayout = 3
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc="Undo Tree"})
    end,
  },
}
