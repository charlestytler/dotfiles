return {
  "j-morano/buffer_manager.nvim",
  event = "BufEnter",
  opts = {},
  keys = {
    { "<leader>b", "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>", desc = "Buffer Manager" },
    { "(", "<cmd>lua require('buffer_manager.ui').nav_prev()<CR>", desc = "Buffer Prev" },
    { ")", "<cmd>lua require('buffer_manager.ui').nav_next()<CR>", desc = "Buffer Next" },
  },
}
