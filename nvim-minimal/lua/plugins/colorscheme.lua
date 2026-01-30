return {
	{
		"alexmozaidze/palenight.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			local groups = require("palenight.groups")

			-- Highlight overrides
			groups["DiffAdd"] = { fg = "NONE", bg = "#405050" }
			groups["DiffChange"] = { fg = "NONE", bg = "#555555" }
			groups["DiffDelete"] = { fg = "NONE", bg = "#875c60" }
			groups["DiffText"] = { bold = true, fg = "NONE", bg = "#1f1500" }
		end,
		config = function()
			vim.cmd("colorscheme palenight")
		end,
	},
}
