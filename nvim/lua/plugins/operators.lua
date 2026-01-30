local nvim_surround = {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup {
      -- Configuration here, or leave empty to use defaults
      --
      -- Examples:
      --
      --   Old text                    Command         New text
      ---------------------------------------------------------------------
      -- surr*ound_words             ysiw)           (surround_words)
      -- surr*ound_words             ysiw(           ( surround_words )
      -- *make strings               ys$"            "make strings"
      -- [delete ar*ound me!]        ds]             delete around me!
      -- remove <b>HTML t*ags</b>    dst             remove HTML tags
      -- 'change quot*es'            cs'"            "change quotes"
      -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
      -- delete(functi*on calls)     dsf             function calls
    }
  end,
}

local align = {
  "Vonr/align.nvim",
  keys = {
    -- stylua: ignore start
    { mode = "x", ";aa", function()
        require("align").align_to_char { length = 1 }
      end, desc = "Aligns to 1 char", },

    { mode = "x", ";a2", function()
        require("align").align_to_char { preview = true, length = 2, }
      end, desc = "Aligns to 2 chars", },

    { mode = "x", ";as", function()
        require("align").align_to_string { preview = true, regex = false, }
      end, desc = "Aligns to string", },

    { mode = "x", ";ar", function()
        require("align").align_to_string { preview = true, regex = true, }
      end, desc = "Aligns to Vim regex", },
    -- stylua: ignore end
  },
}

local mini_ai = {
  "echasnovski/mini.ai",
  version = false,
  event = "VeryLazy",
  opts = {},
}

local mini_operators = {
  "echasnovski/mini.operators",
  version = false,
  event = "VeryLazy",
  opts = {
    evaluate = { prefix = "" },
    exchange = {
      prefix = ";x",
      -- Whether to reindent new text to match previous indent
      reindent_linewise = true,
    },
    multiply = { prefix = "", func = nil }, -- Multiply (duplicate) text
    replace = { prefix = "" }, -- Replace text with register
    sort = { prefix = "<leader>cs" },
  },
}

return {
  nvim_surround,
  align,
  mini_ai,
  mini_operators,
}
