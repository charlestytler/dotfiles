local timber = {
  "Goose97/timber.nvim",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("timber").setup {
      log_templates = {
        default = {
          go = [[log.Printf("%log_marker [%filename:%line_number] %log_target: %v\n", %log_target)]],
          rust = [[println!("%log_marker [%filename:%line_number] %log_target: {:#?}", %log_target);]],
          python = [[print("%log_marker [%filename:%line_number] %log_target", %log_target)]],
          c = [[printf("%log_marker [%filename:%line_number] %log_target: %s\n", %log_target);]],
          cpp = [[std::cout << "%log_marker [%filename:%line_number] %log_target: " << %log_target << std::endl;]],
          java = [[System.out.println("%log_marker [%filename:%line_number] %log_target: " + %log_target);]],
          c_sharp = [[Console.WriteLine($"%log_marker [%filename:%line_number] %log_target: {%log_target}");]],
          odin = [[fmt.printfln("%log_marker [%filename:%line_number] %log_target: %v", %log_target)]],
          bash = [[echo "%log_marker [%filename:%line_number] %log_target: ${%log_target}"]],
          lua = [[print("%log_marker [%filename:%line_number] %log_target: " .. %log_target)]],
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
    }

    vim.keymap.set(
      { "n" },
      "<leader>lc",
      "<cmd>lua require('timber.actions').clear_log_statements()<CR>",
      { desc = "Clear log statements" }
    )
  end,
}

return {
  timber,
}
