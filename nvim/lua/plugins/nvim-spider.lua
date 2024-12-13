return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      ";w",
      "<cmd>lua require('spider').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase w",
    },
    {
      ";e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase e",
    },
    {
      ";b",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase b",
    },
    -- Punctuation skipping option off
    {
      ";W",
      "<cmd>lua require('spider').motion('w', {skipInsignificantPunctuation = false})<CR>",
      mode = { "n", "o", "x" },
      desc = "camelCase w (noskip punct.)",
    },
  },
}
