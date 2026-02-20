local gitsigns = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  opts = {},
}

local octo = {
  "pwntester/octo.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- OR 'ibhagwan/fzf-lua',
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Octo",
  config = function()
    require("octo").setup()
  end,
}

return {
  gitsigns,
  octo,
}
