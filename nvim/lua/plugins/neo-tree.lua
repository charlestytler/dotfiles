return {
  -- Disable NvChad's default tree
  { "nvim-tree/nvim-tree", opts = { disable_netrw = false }, enabled = false },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute { toggle = true, dir = LazyVim.root() }
        end,
        desc = "Find in Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute { action = "focus" }
        end,
        desc = "Explorer NeoTree focus",
      },
      { "<C-n>", "<leader>fE", desc = "Explorer NeoTree toggle", remap = true },
      { "<leader>t", ":Neotree reveal<CR>", desc = "Reveal file in tree", remap = false },
      {
        "<leader>gs",
        function()
          require("neo-tree.command").execute { source = "git_status", toggle = true }
        end,
        desc = "Git status",
      },
      {
        "<leader>b",
        function()
          require("neo-tree.command").execute { source = "buffers", toggle = true }
        end,
        desc = "Buffer Explorer",
      },
    },
  },
}
