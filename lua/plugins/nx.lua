return {
	{
		"Equilibris/nx.nvim",

		dependencies = {
			"nvim-telescope/telescope.nvim",
		},

		opts = {
			-- See below for config options
			nx_cmd_root = "nx",
		},

		-- Plugin will load when you use these keys
		keys = {
			-- { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions" },
		},
		config = function()
			require("nx").setup({
				nx_cmd_root = "nx",
				command_runner = require("nx.command-runners").terminal_cmd(),
				form_renderer = require("nx.form-renderers").telescope(),
				read_init = true,
			})
		end,
	},
}
