-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- or :help lspconfig-all
local servers_with_default_config = {
  "lua_ls",
  "html",
  "cssls",
  "clangd",
  "ts_ls",
  "bashls",
  "julials",
}

local servers_with_custom_config = {
  "basedpyright",
  "neocmake",
}

local all_servers = {}
vim.list_extend(all_servers, servers_with_default_config)
vim.list_extend(all_servers, servers_with_custom_config)

local map_on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  local map = vim.keymap.set

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  -- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
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

local lspconfig = {
  "neovim/nvim-lspconfig",
  config = function()
    -- require "lsp_config.config"

    -- load defaults i.e lua_lsp
    require("nvchad.configs.lspconfig").defaults()

    local lspconfig = require "lspconfig"
    local nvlsp = require "nvchad.configs.lspconfig"

    -- lsps with default config
    for _, lsp in ipairs(servers_with_default_config) do
      lspconfig[lsp].setup {
        -- on_attach = nvlsp.on_attach,
        on_attach = map_on_attach,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
      }
    end

    -- Language servers with custom config
    lspconfig["basedpyright"].setup {
      on_attach = map_on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      settings = {
        basedpyright = {
          typeCheckingMode = "standard",
        },
      },
    }

    lspconfig["neocmake"].setup {
      on_attach = map_on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      cmd = { "neocmakelsp", "stdio" },
      filetypes = { "cmake" },
      single_file_support = true, -- suggested
      init_options = {
        format = { enable = true },
        lint = { enable = true },
        scan_cmake_in_package = true, -- default is true
      },
    }

    -- lspconfig["julials"].setup {
    --   on_attach = map_on_attach,
    --   on_init = nvlsp.on_init,
    --   capabilities = nvlsp.capabilities,
    --   on_new_config = function(new_config, _)
    --     local julia = vim.fn.expand "~/.julia/environments/nvim-lspconfig/bin/julia"
    --     if require("lspconfig").util.path.is_file(julia) then
    --       vim.notify("julia found", vim.log.levels.INFO)
    --       new_config.cmd[1] = julia
    --     end
    --   end,
    -- }
  end,
  dependencies = {
    "antosha417/nvim-lsp-file-operations",
    "williamboman/mason-lspconfig.nvim",
  },
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  -- Ensure plugins are loaded in order: mason, mason-lspconfig, nvim-lspconfig
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    ensure_installed = all_servers,
  },
}

return {
  mason_lspconfig,
  lspconfig,
}
