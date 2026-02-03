return {
	"Skicken/template.nvim",
	cmd = { "Template" },
	config = function()
		require("template").setup({
			temp_dir = "~/.config/nvim/templates",
		})
		vim.keymap.set("n", "<leader>ti", function()
			vim.cmd("Telescope find_template type=insert")
		end, { desc = "[T]emplate [I]nsert" })
	end,
}
