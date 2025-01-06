return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Plugins
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = require "configs.snacks-dashboard",
    indent = { enabled = false },
    notify = { enabled = false }, -- allows for `lua Snacks.notify("custom message")`
    notifier = {
      enabled = true,
      timeout = 2000,
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
  -- stylua: ignore start
  keys = {
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
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.dim():map("<leader>us") -- name: 
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.line_number():map("<leader>ul")
        -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uH")
        Snacks.toggle.zen():map("<leader>uz")
      end,
    })
  end,
}
