local snacks = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Plugins
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = require "configs.dashboard",
    indent = { enabled = false },
    notify = { enabled = false }, -- allows for `lua Snacks.notify("custom message")`
    notifier = {
      enabled = true,
      timeout = 2000,
    },
    picker = {
      layouts = {
        -- Make dropdown default wider
        dropdown = {
          layout = {
            width = 0.8, -- default: 0.4
          },
        },
      },
      previewers = {
        git = {
          native = true,
        },
      },
    },
    quickfile = { enabled = true },
    rename = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    words = { enabled = true },
    -- Additional Options
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    -- stylua: ignore start
    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>un",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>x", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>ux", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    -- { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

    -- PICKER KEYS

    -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep({ layout={preset="dropdown"} }) end, desc = "Grep" },
    -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<C-p>", function() Snacks.picker.files({layout={preset="vscode"}}) end, desc = "Find Files" },
    -- find
    -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config"), layout={preset="select"} }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files({ layout={preset="select"} }) end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fl", function() Snacks.picker.picker_layouts() end, desc = "Layout select" },
    -- git
    { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
    -- { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },

    --  Custom pick: pick(<string> source, <snacks.picker.Config> opts)
    { "<leader>fs", function() Snacks.picker.git_files {
          cwd = Snacks.git.get_root(),
          args = { "diff-tree", "--no-commit-id", "--name-only", "--diff-filter=d", "HEAD", "-r" },
          title = "Git Last Commit",
          preview = "git_show",
        } end, desc = "Find in Git Show"},
    { "<leader>fb", function() Snacks.picker.git_files {
          cwd = Snacks.git.get_root(),
          args = { "diff", "--name-only", "HEAD@{u}..HEAD" },
          title = "Git Branch Changed Files",
        } end, desc = "Find in Git Branch"},
    { "<leader>fd", function() Snacks.picker.git_status() end, desc = "Find in Git Diff" },
    -- { "<leader>fs", function() Snacks.picker.files({cmd="git show --format=oneline --name-only | tail -n +2"}) end, desc = "Find in Git Show" },
    -- { "<leader>fb", function() Snacks.picker.pick("git diff HEAD@{u}..HEAD --name-only") end, desc = "Find in Git Branch" },
    -- { "<leader>fb", function() Snacks.picker.pick("git diff --name-only") end, desc = "Find in Git Diff" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers({ layout = "dropdown" }) end, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep({ layout = "dropdown" }) end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word({ layout = "dropdown" }) end, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers({ layout = "dropdown" }) end, desc = "Registers" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    -- { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>s:", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sh", function() Snacks.picker.help({ layout = "ivy" }) end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sq", function() Snacks.picker.qflist({ layout = "ivy" }) end, desc = "Quickfix List" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo" },
    -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions({ layout = "ivy" }) end, desc = "Goto Definition" },
    { "gr", function() Snacks.picker.lsp_references({ layout = "ivy" }) end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations({ layout = "ivy" }) end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions({ layout = "ivy" }) end, desc = "Goto T[y]pe Definition" },
    { "<leader>cD", function() Snacks.picker.diagnostics_buffer({ layout = "ivy" }) end, desc = "Diagnostics in Buffer" },
    { "<leader>cp", function() Snacks.picker.diagnostics({ layout = "ivy" }) end, desc = "Project-wide Diagnostics" },
    -- stylua: ignore end
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- -- Setup some globals for debugging (lazy-loaded)
        -- _G.dd = function(...)
        --   Snacks.debug.inspect(...)
        -- end
        -- _G.bt = function()
        --   Snacks.debug.backtrace()
        -- end
        -- vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
        Snacks.toggle.diagnostics():map "<leader>ud"
        Snacks.toggle.dim():map "<leader>us" -- name:
        Snacks.toggle.indent():map "<leader>ui"
        Snacks.toggle.line_number():map "<leader>ul"
        -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map "<leader>uT"
        -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map "<leader>uH"
        Snacks.toggle.zen():map "<leader>uz"
      end,
    })
  end,
}

return {
  snacks,
}
