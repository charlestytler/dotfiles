local grug_far = {
  "MagicDuck/grug-far.nvim",
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  cmd = { "GrugFar", "GrugFarWithin" },
  opts = {},
  keys = {
    { "<leader>ra", "<cmd>GrugFar<cr>", desc = "Replace All" },
    { "<leader>rw", "<cmd>GrugFarWithin<cr>", desc = "Find within" },
  },
}

return {
  grug_far,
}
