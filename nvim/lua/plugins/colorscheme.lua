return {
  {
    "alexmozaidze/palenight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- 1. Define the overrides in an autocommand
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "palenight",
        callback = function()
          local highlights = {
            DiffAdd = { fg = "NONE", bg = "#405050" },
            DiffChange = { fg = "NONE", bg = "#555555" },
            DiffDelete = { fg = "NONE", bg = "#875c60" },
            DiffText = { bold = true, fg = "NONE", bg = "#1f1500" },
            Title = { fg = "#82aaff" },
          }

          for group, settings in pairs(highlights) do
            vim.api.nvim_set_hl(0, group, settings)
          end
        end,
      })

      -- 2. Load the colorscheme
      vim.cmd "colorscheme palenight"
    end,
  },
}
