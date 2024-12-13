return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  config = function()
    local actions = require "fzf-lua.actions"
    require("fzf-lua").setup {
      winopts = {
        height = 0.5,
        width = 0.5,
        row = 0.4,
        hl = { normal = "Pmenu" },
        border = "none",
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
          -- ["enter"] = actions.file_edit_or_qf,  -- Default
          ["enter"] = actions.file_edit,
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
        preview_opts = "hidden",
        no_header = true,
      },
      buffers = {
        formatter = "path.filename_first",
        prompt = "buffers:",
        preview_opts = "hidden",
        no_header = true,
        fzf_opts = { ["--delimiter"] = " ", ["--with-nth"] = "-1.." },
        winopts = {
          height = 0.5,
          width = 0.3,
        },
      },
      helptags = {
        prompt = "💡:",
        preview_opts = "hidden",
        winopts = {
          row = 1,
          width = vim.api.nvim_win_get_width(0),
          height = 0.3,
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
            row = 0.3,
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
          preview_opts = "nohidden",
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
        preview_opts = "hidden",
        winopts = {
          width = 0.8,
          height = 0.7,
          preview = {
            layout = "horizontal",
            horizontal = "down:45%",
          },
        },
      },
    }
  end,
  keys = {
    { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>b", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },

    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files (cwd)" },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find buffers" },
    { "<leader>fm", "<cmd>FzfLua marks<CR>", desc = "Find marks" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Find oldfiles" },
    { "<leader>f:", "<cmd>FzfLua commands<CR>", desc = "Find commands" },
    { "<leader>fp", "<cmd>FzfLua registers<CR>", desc = "Find paste register" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keybindings " },

    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Search files" },
    -- map({ "n", "v" }, "<leader>sg", "<cmd>Telescope grep_string<CR>", { desc = "Search grep under cursor" })
    { "<leader>s/", "<cmd>FzfLua current_buffer_fuzzy_find<CR>", desc = "Search in current file" },
    { "<leader>sh", "<cmd>FzfLua help_tags<CR>", desc = "Search help" },
    -- { "<leader>sc", "<cmd>FzfLua live_grep cwd=$HOME/.config/nvim<CR>", desc = "Search config files" },

    { "<leader>gc", "<cmd>FzfLua git_bcommits<CR>", desc = "git commits" },
    { "<leader>gd", "<cmd>FzfLua git_status<CR>", desc = "git diff" },
    { "<leader>gt", "<cmd>FzfLua git_stash<CR>", desc = "git stash" },

    { "<leader>cq", "<cmd>FzfLua quickfix<CR>", desc = "Code quickfix" },
  },
}
