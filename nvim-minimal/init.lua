require("config.lazy")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("options")
require("autocmds")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "palenight" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Load user mappings after initializing core setup.
vim.schedule(function()
	require("user_mappings")
end)
