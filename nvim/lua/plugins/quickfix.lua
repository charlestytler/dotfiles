local quicker = {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  keys = {
    { "<leader>qq", "<cmd>lua require('quicker').toggle({ focus = true })<cr>", desc = "Quickfix toggle" },
    { "<leader>qe", "<cmd>lua require('quicker').toggle_expand()<cr>", desc = "Quickfix expand" },
    { "<leader>qn", "<cmd>cn<cr>", desc = "Quickfix next" },
    { "<leader>qp", "<cmd>cp<cr>", desc = "Quickfix prev" },
  },
}

return {
  quicker,
}
