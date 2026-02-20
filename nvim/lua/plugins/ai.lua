local copilot = {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    -- vim.keymap.set("i", "<Tab>", "<Plug>(copilot-accept)", { desc = "Complete" })
    vim.keymap.set("i", ";<Tab>", "copilot#Accept-line", { desc = "Accept line" })
    vim.keymap.set("i", "jl", "<Plug>(copilot-dismiss)", { desc = "Dismiss" })
  end,
}

local codeium = {
  "Exafunction/codeium.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  keys = {
    { "<leader>a", "<cmd>Codeium Chat<CR>", desc = "Ask Codeium chat" },
    { "<leader>ac", "<cmd>Codeium Toggle<CR>", desc = "Completion toggle" },
  },
  opts = {
    enable_cmp_source = true,
    virtual_text = {
      enabled = true,
      key_bindings = {
        accept = "<Tab>",
        accept_line = ";<Tab>",
        clear = "jl",
      },
    },
  },
}

local codecompanion = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "VeryLazy",
  config = function() -- This is the function that runs, AFTER loading
    require("codecompanion").setup {
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
      },
    }
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "[A]sk (chat)" },
    { "<leader>am", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "[M]enu" },
    { "<leader>ap", "<cmd>CodeCompanionChat Add<CR>", mode = { "v" }, desc = "[P]aste" },
  },
}

local neocodeium = {
  "monkoose/neocodeium",
  event = "BufEnter",
  config = function()
    local neocodeium = require "neocodeium"
    neocodeium.setup()
    vim.keymap.set("i", "<Tab>", neocodeium.accept)
    vim.keymap.set("i", ";<Tab>", neocodeium.accept_line)
    vim.keymap.set("i", "jl", neocodeium.clear)
    vim.keymap.set("n", "<leader>at", "<cmd>NeoCodeium toggle<CR>", { desc = "[T]oggle autocomplete" })
    vim.keymap.set("n", "<leader>al", "<cmd>NeoCodeium open_log<CR>", { desc = "[L]og file" })
    vim.keymap.set("n", "<leader>ar", "<cmd>NeoCodeium restart<CR>", { desc = "[R]estart server" })
  end,
}

return {
  -- copilot,
  codeium,
  codecompanion,
  -- neocodeium
}
