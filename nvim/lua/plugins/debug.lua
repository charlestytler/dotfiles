local timber = {
  "Goose97/timber.nvim",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
    log_templates = {
      default = {
        lua = [[print("%log_marker " .. %log_target)]],
        javascript = [[console.log("%log_marker [%filename:%line_number] %log_target = ", %log_target)]],
        typescript = [[console.log("%log_marker [%filename:%line_number] %log_target = ", %log_target)]],
        jsx = [[console.log("%log_marker [%filename:%line_number] %log_target = ", %log_target)]],
        tsx = [[console.log("%log_marker [%filename:%line_number] %log_target = ", %log_target)]],
      },
    },
    keymaps = {
      -- Set to false to disable the default keymap for specific actions
      -- insert_log_below = false,
      insert_log_below = "<leader>lj",
      insert_log_above = "<leader>lk",
      insert_plain_log_below = "<leader>lo",
      insert_plain_log_above = "<leader>lO",
      insert_batch_log = "<leader>lb",
      add_log_targets_to_batch = "<leader>la",
      insert_log_below_operator = "<leader>lJ",
      insert_log_above_operator = "<leader>lK",
      insert_batch_log_operator = "<leader>lB",
      add_log_targets_to_batch_operator = "<leader>lA",
    },
    log_marker = "🪵", -- Or any other string, e.g: MY_LOG
    -- default_keymaps_enabled = false,
  },
}

return {
  timber,
}
