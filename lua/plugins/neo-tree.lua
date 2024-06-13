return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	init = function()
		require("neo-tree.command").execute({
			toggle = true,
			position = "left",
		})
	end,
	keys = {
		{
			"<C-o>",
			function()
				require("neo-tree.command").execute({
					toggle = true,
					position = "left",
				})
			end,
		},
		{
			"<C-G>",
			function()
				require("neo-tree.git.status").execute({
					toggle = true,
					position = "left",
				})
			end,
		},
	},
	opts = {

		filesystem = {
			hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
		},
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
		})
	end,
}
