local flavour_color_overrides = {
  latte = {
    -- Toned-down Sepia (less "yellow", more "neutral paper")
    base = "#f2ede3", -- Muted parchment base
    mantle = "#e6dfd3", -- Softer sidebar
    crust = "#dbd3c6", -- Muted borders

    -- High Contrast Dark Text
    text = "#1a1a1a", -- Sharp dark grey-black
    subtext1 = "#333333",

    -- Darker, "Ochre" Yellow for better legibility on light background
    yellow = "#a0522d", -- Sienna/Clay brown
    peach = "#bf6c22", -- Darker orange/tan for contrast

    -- Optional: Desaturate other colors to match the "old book" feel
    green = "#5b7a5b", -- Forest green
    blue = "#45707a", -- Steel blue
    mauve = "#88507a", -- Dusky plum (replaces bright purple)

    -- UI elements
    surface0 = "#dfd8cc",
    surface1 = "#d3ccbf",
  },
  macchiato = {
    -- Deep Blue-Grey Backgrounds (Palenight style)
    base = "#292d3e", -- Main background (Palenight standard)
    mantle = "#1b1e2b", -- Darker sidebar/UI
    crust = "#141622", -- Darkest borders
  },
}

local function pick_catppuccin_flavour()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"
  local entry_display = require "telescope.pickers.entry_display"

  local flavours = { "latte", "frappe", "macchiato", "mocha" }
  local original = require("catppuccin").flavour or "frappe"
  local confirmed = false

  local function apply_flavour()
    local selection = action_state.get_selected_entry()
    if not selection then
      return
    end
    local flavour = selection[1]
    require("catppuccin").setup { flavour = flavour, color_overrides = flavour_color_overrides }
    vim.cmd.colorscheme "catppuccin"
  end

  -- Find the index of current flavour for initial selection
  local initial_index = 1
  for i, f in ipairs(flavours) do
    if f == original then
      initial_index = i
      break
    end
  end

  pickers
    .new({}, {
      prompt_title = "Select Catppuccin Theme Flavour",
      prompt_prefix = "",
      finder = finders.new_table { results = flavours },
      sorter = conf.generic_sorter {},
      previewer = false,
      layout_strategy = "center",
      layout_config = { width = 0.3, height = 8 },
      sorting_strategy = "ascending",
      default_selection_index = initial_index, -- <-- initial highlight
      attach_mappings = function(prompt_bufnr, map)
        local function move_and_preview(move_action)
          return function()
            move_action(prompt_bufnr)
            apply_flavour()
          end
        end

        -- live preview for multiple keys
        for _, key in ipairs { "<C-j>", "<C-n>", "<Down>" } do
          map("i", key, move_and_preview(actions.move_selection_next))
        end
        for _, key in ipairs { "<C-k>", "<C-p>", "<Up>" } do
          map("i", key, move_and_preview(actions.move_selection_previous))
        end

        -- confirm selection
        actions.select_default:replace(function()
          confirmed = true
          apply_flavour()
          actions.close(prompt_bufnr)
        end)

        -- revert only if not confirmed
        actions.close:enhance {
          post = function()
            if not confirmed then
              require("catppuccin").setup { flavour = original }
              vim.cmd.colorscheme "catppuccin"
            end
          end,
        }

        return true
      end,
    })
    :find()
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "macchiato",
        color_overrides = flavour_color_overrides,
        auto_integrations = true,
      }

      vim.cmd.colorscheme "catppuccin"
    end,
    keys = {
      { "<leader>ut", pick_catppuccin_flavour, desc = "Theme Pick: Catppuccin Flavour" },
    },
  },
}
