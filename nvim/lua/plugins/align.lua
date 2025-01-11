return {
  "Vonr/align.nvim",
  keys = {
    {
      mode = "x",
      ";aa",
      function()
        require("align").align_to_char {
          length = 1,
        }
      end,
      desc = "Aligns to 1 char",
    },
    {
      mode = "x",
      ";a2",
      function()
        require("align").align_to_char {
          preview = true,
          length = 2,
        }
      end,
      desc = "Aligns to 2 chars",
    },
    {
      mode = "x",
      ";as",
      function()
        require("align").align_to_string {
          preview = true,
          regex = false,
        }
      end,
      desc = "Aligns to string",
    },
    {
      mode = "x",
      ";ar",
      function()
        require("align").align_to_string {
          preview = true,
          regex = true,
        }
      end,
      desc = "Aligns to Vim regex",
    },
  },
}
