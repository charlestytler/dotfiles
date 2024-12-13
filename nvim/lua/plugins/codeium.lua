return {
  "Exafunction/codeium.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  keys = {
    { "<leader>a", "<cmd>Codeium Chat<CR>", desc = "Ask Codeium chat" },
  },
  opts = {
    enable_cmp_source = true,
    virtual_text = {
      enabled = true,
      key_bindings = {
        accept = "<Tab>",
        accept_word = ";<Tab>",
        clear = "jl",
      },
    },
  },
}
