local flavour_color_overrides = {
	macchiato = {
		-- Deep Blue-Grey Backgrounds (Palenight style)
		base = "#292d3e", -- Main background (Palenight standard)
		mantle = "#1b1e2b", -- Darker sidebar/UI
		crust = "#141622", -- Darkest borders
	},
}

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato",
				color_overrides = flavour_color_overrides,
				auto_integrations = true,
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
