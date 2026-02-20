local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  -- map("n", "gI", vim.lsp.buf.implementation, opts "Go to implementation")
  -- map("n", "gt", vim.lsp.buf.type_definition, opts "Go to type definition")
  --
  -- map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts "Go to definition")
  -- map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts "Go to implementation")
  -- map("n", "gs", "<cmd>Telescope lsp_signature_help<CR>", opts "Show signature help")
  -- map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts "Go to type definition")
  -- map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts "Show references")
  -- map({ "n", "v" }, "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", opts "Code action")

  map("n", "gi", vim.lsp.buf.hover, opts "Show hover info")
  map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>cwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>rs", require "nvchad.lsp.renamer", opts "Rename Symbol")

  -- map("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts "Diagnostics for file")
  map("n", "<leader>cd", vim.diagnostic.open_float, opts "Diagnostics for current line")
  map("n", "[d", vim.diagnostic.goto_prev, opts "Goto previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, opts "Goto next diagnostic")

  map("n", "<leader>cR", ":LspRestart<CR>", opts "Restart LSP")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if vim.fn.has "nvim-0.11" ~= 1 then
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })

  local lua_lsp_settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          "${3rd}/luv/library",
        },
      },
    },
  }

  -- Use new vim.lsp.config API for Neovim 0.11+
  vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
  vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
  vim.lsp.enable "lua_ls"
end

return M
