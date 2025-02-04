local mini_animate = {
  "echasnovski/mini.animate",
  version = false,
  event = "VeryLazy",
  opts = {},
}

local mini_icons = {
  "echasnovski/mini.icons",
  version = false,
  event = "VeryLazy",
  opts = {},
}

local inline_diagnostic = {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup()
  end,
}

local colorful_winsep = {
  "nvim-zh/colorful-winsep.nvim",
  config = true,
  event = { "WinLeave" },
  opts = {},
}

local incline = {
  "b0o/incline.nvim",
  event = "BufReadPre",
  dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>uh", '<Cmd>lua require"incline".toggle()<Cr>', desc = "Headers: Toggle" },
  },
  config = function()
    require("incline").setup {
      window = {
        zindex = 30,
        margin = {
          vertical = { top = vim.o.laststatus == 3 and 0 or 1, bottom = 0 }, -- shift to overlap window borders
          horizontal = { left = 0, right = 2 },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"

        local function get_git_diff()
          local icons = { removed = " ", changed = " ", added = " " }
          icons["changed"] = icons.modified
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          for name, icon in pairs(icons) do
            if tonumber(signs[name]) and signs[name] > 0 then
              table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
            end
          end
          if #labels > 0 then
            table.insert(labels, { "┊ " })
          end
          return labels
        end
        local function get_diagnostic_label()
          local icons = { error = "", warn = " ", info = " ", hint = "" }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "┊ " })
          end
          return label
        end

        local buffer = {
          { get_diagnostic_label() },
          { get_git_diff() },
          { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
          { filename .. " ", gui = modified },
        }
        return buffer
      end,
    }
  end,
}

local noice = {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "70%",
        },
      },
    },
    cmdline = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
    },
    lsp = {
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
      },
      -- defaults for hover and signature help
      documentation = {
        view = "hover",
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    -- Hide messages after ":w"
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        filter = {
          find = "Config Change Detected",
        },
        opts = { skip = true },
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
}

return {
  -- mini_animate,
  mini_icons,
  inline_diagnostic,
  colorful_winsep,
  incline,
  noice,
}
