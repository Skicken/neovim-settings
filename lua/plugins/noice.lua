return {
	event = "VeryLazy",
	"folke/noice.nvim",
	opts = {},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		vim.keymap.set("n", "<leader>nt", function()
			require("noice").cmd("telescope")
		end, { desc = "Telescope Noice" })
		vim.keymap.set("n", "<leader>un", function()
			require("noice").cmd("dismiss")
		end, { desc = "Dismiss Noice" })

		require("noice").setup({
			messages = {

				enabled = true, -- enables the Noice messages UI
				view = "mini", -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "mini", -- view for warnings
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
		})
	end,
}
