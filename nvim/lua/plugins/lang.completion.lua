-- This is only a modification of NvChad's cmp config
local nvim_cmp = {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require "cmp"
    cmp.setup {
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),

        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },

        -- disable completion with tab as it conflicts with other AI completion tools
        ["<Tab>"] = cmp.config.disable,

        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.select_next_item()
        --   -- elseif require("luasnip").expand_or_jumpable() then
        --   --   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        --   elseif vim.b._copilot_suggestion ~= nil then
        --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes(vim.fn["copilot#Accept"](), true, true, true), "")
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        -- { name = "codeium" },
      },
      enabled = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
          return false
        end
        local is_floating = vim.api.nvim_win_get_config(0).relative ~= ""
        if is_floating then
          return false
        end
        return true
      end,
    }
  end,
}

return {
  nvim_cmp,
}
