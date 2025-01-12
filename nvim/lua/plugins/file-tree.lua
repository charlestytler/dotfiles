-- Disable NvChad's default tree
local nvim_tree = {
  "nvim-tree/nvim-tree",
  opts = { disable_netrw = false },
  enabled = false,
}

local neo_tree = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = "Neotree",
  opts = {
    close_if_last_window = true,

    -- Auto close on file open
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          -- auto close
          -- vim.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute { action = "close" }
        end,
      },
    },

    -- Show harpoon index numbers
    filesystem = {
      components = {
        harpoon_index = function(config, node, _)
          local harpoon_list = require("harpoon"):list()
          local path = node:get_id()
          local harpoon_key = vim.uv.cwd()

          for i, item in ipairs(harpoon_list.items) do
            local value = item.value
            if string.sub(item.value, 1, 1) ~= "/" then
              value = harpoon_key .. "/" .. item.value
            end

            if value == path then
              vim.print(path)
              return {
                text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            end
          end
          return {}
        end,
      },
      renderers = {
        file = {
          { "icon" },
          { "name", use_git_status_colors = true },
          { "harpoon_index" }, --> This is what actually adds the component in where you want it
          { "diagnostics" },
          { "git_status", highlight = "NeoTreeDimText" },
        },
      },
    },
  },
  keys = {
    {
      "<C-n>",
      function()
        require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
      end,
      desc = "Explorer NeoTree toggle",
    },
    { "<leader>e", ":Neotree reveal<CR>", desc = "[E]xplorer Reveal File", remap = false },
    {
      "<leader>gs",
      function()
        require("neo-tree.command").execute { source = "git_status", toggle = true }
      end,
      desc = "Git status",
    },
    -- {
    --   "<leader>b",
    --   function()
    --     require("neo-tree.command").execute { source = "buffers", toggle = true }
    --   end,
    --   desc = "Buffer Explorer",
    -- },
  },
}

return {
  nvim_tree,
  neo_tree,
}
