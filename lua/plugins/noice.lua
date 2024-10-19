return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		vim.keymap.set("n", "<leader>nt", ":Noice telescope  <CR>")
		vim.keymap.set("n", "<leader>nn", ":Noice dismiss  <CR>")

		require("noice").setup({
			views = {
				notify = {
					replace=true,
				},
			},
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
