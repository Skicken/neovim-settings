return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	init = function()
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
			desc = "Opening neotree",
		},
	},
	opts = {

		filesystem = {
			hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
		},
	},
	config = function()
		vim.keymap.set("n", "<C-g>", ":Neotree git_status <CR>")
		vim.keymap.set("n", "<leader>oo", ":Neotree focus <CR>")
		require("neo-tree").setup({

			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			close_if_last_window = false,
			filesystem = {
				window = {
					width = 40,
					mappings = {
						["<leader>tt"] = {
							command = function(state)
								local node = state.tree:get_node()
								local user_input = vim.fn.input("Command Input")
								local out = vim.cmd("!cd " .. node.path .. " &&" .. user_input)

								vim.print(node.path)
								if vim.v.shell_error ~= 0 then
									-- print(out)
								end
							end,
						},
					},
				},
			},
		})
	end,
}
