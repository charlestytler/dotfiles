-- Overwrite NvChad on_attach capabilities
local M = {}

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  local map = vim.keymap.set

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gi", vim.lsp.buf.signature_help, opts "Show signature help")

  -- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  -- map("n", "gI", vim.lsp.buf.implementation, opts "Go to implementation")
  -- map("n", "gt", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts "Go to definition")
  map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts "Go to implementation")
  map("n", "gi", "<cmd>Telescope lsp_signature_help<CR>", opts "Show signature help")
  map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts "Go to type definition")
  map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts "Show references")

  map("n", "gi", vim.lsp.buf.hover, opts "Show hover info")
  map("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>cwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>rs", require "nvchad.lsp.renamer", opts "Rename Symbol")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")

  map("n", "<leader>cD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts "Diagnostics for file")
  map("n", "<leader>cd", vim.diagnostic.open_float, opts "Diagnostics for current line")
  map("n", "[d", vim.diagnostic.goto_prev, opts "Goto previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, opts "Goto next diagnostic")

  map("n", "<leader>cR", ":LspRestart<CR>", opts "Restart LSP")
end

return M
