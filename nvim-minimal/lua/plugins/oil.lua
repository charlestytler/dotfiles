return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		keymaps = {
			["<leader>?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<M-l>"] = { "actions.select", opts = { vertical = true } },
			["<M-j>"] = { "actions.select", opts = { horizontal = true } },
			["<C-t>"] = { "actions.select", opts = { tab = true } },
			["<C-h>"] = false,
			["<C-p>"] = "actions.preview",
			["<C-c>"] = { "actions.close", mode = "n" },
			["<C-5>"] = "actions.refresh",
			["<C-l>"] = false,
			["<BS>"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["`"] = { "actions.cd", mode = "n" },
			["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
			["gs"] = { "actions.change_sort", mode = "n" },
			["gx"] = "actions.open_external",
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["g\\"] = { "actions.toggle_trash", mode = "n" },
		},
		view_options = {
			show_hidden = true,
		},
	},
	cmd = { "Oil" },
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	keys = {
		{ "<leader>o", "<cmd>Oil<cr>", desc = "Open oil" },
	},
}
