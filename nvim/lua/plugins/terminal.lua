local tmux_navigator = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window Select " },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window Select " },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window Select " },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window Select " },
    },
  },
}

return {
  tmux_navigator,
}
