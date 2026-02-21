require "configs.lazy"

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require "options"
require "user_functions"
require "filetype_associations"
require "lsp_mappings"

-- Setup lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

-- Load user mappings after initializing core setup.
vim.schedule(function()
  require "user_mappings"
end)
