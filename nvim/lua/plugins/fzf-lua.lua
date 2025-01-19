return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  config = function()
    local actions = require "fzf-lua.actions"
    require("fzf-lua").setup {
      -- winopts    = {
      --   width   = 0.8,
      --   height  = 0.9,
      --   preview = {
      --     hidden       = "nohidden",
      --     vertical     = "up:45%",
      --     horizontal   = "right:50%",
      --     layout       = "flex",
      --     flip_columns = 120,
      --     delay        = 10,
      --     winopts      = { number = false },
      --   },
      -- },
      -- hls        = {
      --   normal         = hl_validate "TelescopeNormal",
      --   border         = hl_validate "TelescopeBorder",
      --   title          = hl_validate "TelescopePromptTitle",
      --   help_normal    = hl_validate "TelescopeNormal",
      --   help_border    = hl_validate "TelescopeBorder",
      winopts = {
        height = 0.9,
        width = 0.9,
        row = 0.4,
        hls = { normal = "Pmenu" },
        border = "none",
        preview = {
          hidden = "nohidden",
          layout = "flex",
          vertical = "down:45%",
          horizontal = "right:50%",
          flip_columns = 170,
          delay = 10,
          winopts = { number = false },
        },
      },
      fzf_opts = {
        ["--no-info"] = "",
        ["--info"] = "hidden",
        ["--padding"] = "10%,2%,10%,2%",
        ["--header"] = " ",
        ["--no-scrollbar"] = "",
      },
      keymap = {
        builtin = {
          true,
          ["<C-p>"] = "toggle-preview",
          ["<C-u>"] = "preview-page-up",
          ["<C-d>"] = "preview-page-down",
        },
      },
      actions = {
        files = {
          ["enter"] = actions.file_edit_or_qf, -- Default
          ["ctrl-q"] = actions.file_send_to_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
          ["alt-Q"] = actions.file_sel_to_ll,
        },
      },
      files = {
        formatter = "path.filename_first",
        git_icons = true,
        prompt = "files:",
        no_header = true,
        winopts = {
          preview = { hidden = "hidden" },
        },
      },
      buffers = {
        formatter = "path.filename_first",
        prompt = "buffers:",
        no_header = true,
        fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
        winopts = {
          height = 0.5,
          width = 0.4,
          preview = { hidden = "hidden" },
        },
      },
      helptags = {
        prompt = "💡:",
        winopts = {
          row = 1,
          width = vim.api.nvim_win_get_width(0),
          height = 0.3,
          preview = { hidden = "hidden" },
        },
      },
      git = {
        status = {
          -- prompt = "file: ",
          winopts = {
            preview = {
              layout = "horizontal",
              horizontal = "bottom:70%",
              -- wrap = "wrap",
            },
            row = 0.2,
            -- width = 0.95,
            width = vim.api.nvim_win_get_width(0),
            height = 0.9,
          },
        },
        bcommits = {
          prompt = "logs:",
          cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen%><(12)%cr%><|(12)%Creset %s' <file>",
          preview = "git show --stat --color --format='%C(cyan)%an%C(reset)%C(bold yellow)%d%C(reset): %s' {1} -- <file>",
          -- actions = {
          -- 	["ctrl-d"] = function(...)
          -- 		fzf.actions.git_buf_vsplit(...)
          -- 		vim.cmd("windo diffthis")
          -- 		local switch = vim.api.nvim_replace_termcodes("<C-w>h", true, false, true)
          -- 		vim.api.nvim_feedkeys(switch, "t", false)
          -- 	end,
          -- },
          winopts = {
            preview = {
              layout = "vertical",
              vertical = "right:50%",
              wrap = "wrap",
            },
            row = 1,
            width = vim.api.nvim_win_get_width(0),
            height = 0.3,
          },
        },
        branches = {
          prompt = "branches:",
          cmd = "git branch --all --color",
          winopts = {
            preview = {
              layout = "vertical",
              vertical = "right:50%",
              wrap = "wrap",
            },
            row = 1,
            width = vim.api.nvim_win_get_width(0),
            height = 0.3,
          },
        },
      },
      autocmds = {
        prompt = "autocommands:",
        winopts = {
          width = 0.8,
          height = 0.7,
          preview = {
            layout = "horizontal",
            horizontal = "down:40%",
            wrap = "wrap",
          },
        },
      },
      keymaps = {
        prompt = "keymaps:",
        winopts = {
          width = 0.8,
          height = 0.7,
        },
        actions = {
          ["default"] = function(selected)
            local lines = vim.split(selected[1], "│", {})
            local mode, key = lines[1]:gsub("%s+", ""), lines[2]:gsub("%s+", "")
            vim.cmd("verbose " .. mode .. "map " .. key)
          end,
        },
      },
      highlights = {
        prompt = "highlights:",
        winopts = {
          width = 0.8,
          height = 0.7,
          preview = {
            layout = "horizontal",
            horizontal = "down:40%",
            wrap = "wrap",
          },
        },
        actions = {
          ["default"] = function(selected)
            print(vim.cmd.highlight(selected[1]))
          end,
        },
      },
      lsp = {
        code_actions = {
          prompt = "code actions:",
          winopts = {
            width = 0.8,
            height = 0.7,
            preview = {
              layout = "horizontal",
              horizontal = "up:75%",
            },
          },
        },
      },
      registers = {
        prompt = "registers:",
        winopts = {
          width = 0.8,
          height = 0.7,
          preview = {
            layout = "horizontal",
            horizontal = "down:45%",
            hidden = "hidden",
          },
        },
      },
    }
  end,
  keys = {
    { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    -- { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" }, Use buffer_manager.lua instead

    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files (cwd)" },
    -- { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
    { "<leader>fd", "<cmd>lua require('fzf-lua').files({ cwd = '~/dotfiles' })<CR>", desc = "Find dotfiles" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Find Recent files" },
    { "<leader>fq", "<cmd>FzfLua quickfix<CR>", desc = "Find in Quickfix list" },
    {
      "<leader>fs",
      "<cmd>lua require('fzf-lua').files({cmd = 'git show --format=oneline --name-only | tail -n +2'})<CR>",
      desc = "Find Git Show Files",
    },
    {
      "<leader>fb",
      "<cmd>lua require('fzf-lua').files({cmd = 'git diff HEAD@{u}..HEAD --name-only'})<CR>",
      desc = "Find Git Branch Files",
    },

    { "<leader>/", "<cmd>FzfLua live_grep_native<cr>", desc = "Search all files" },
    { "<leader>sb", "<cmd>FzfLua lines<CR>", desc = "Search open buffers" },
    { "<leader>sf", "<cmd>FzfLua blines<CR>", desc = "Search current file (fuzzy)" },
    { "<leader>sF", "<cmd>FzfLua lgrep_curbuf<CR>", desc = "Search current file (exact)" },
    { "<leader>sw", "<cmd>FzfLua grep_cword<CR>", desc = "Search word under cursor" },
    { "<leader>sW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Search word under cursor" },
    { "<leader>sh", "<cmd>FzfLua help_tags<CR>", desc = "Search help" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search keybindings " },
    { "<leader>sm", "<cmd>FzfLua marks<CR>", desc = "Search marks" },
    { "<leader>sp", "<cmd>FzfLua registers<CR>", desc = "Search paste register" },
    { "<leader>s:", "<cmd>FzfLua commands<CR>", desc = "Search commands" },
    {
      "<leader>sc",
      "<cmd>lua require('fzf-lua').live_grep_native({cwd = '~/dotfiles'})<CR>",
      desc = "Search config files",
    },

    { "<leader>s", "<cmd>FzfLua grep_visual<CR>", mode = { "v" }, { desc = "Search selection" } },

    { "<leader>gc", "<cmd>FzfLua git_bcommits<CR>", desc = "git commits" },
    { "<leader>gd", "<cmd>FzfLua git_status<CR>", desc = "git diff" },
    { "<leader>gt", "<cmd>FzfLua git_stash<CR>", desc = "git stash" },

    { "<leader>cq", "<cmd>FzfLua quickfix<CR>", desc = "Code quickfix" },
  },
}
