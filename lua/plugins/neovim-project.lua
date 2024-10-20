return {
	"coffebar/neovim-project",
	opts = {
		projects = { -- define project roots
			"~/dev/*",
			"~/.config/nvim/",
		},
	},
	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
		{ "Shatur/neovim-session-manager" },
	},
	config = function()
		vim.keymap.set("n", "<leader>sp", ":SessionManager load_session <CR> ", { desc = "List sessions" })
		vim.keymap.set("n", "<leader>sl", ":SessionManager load_last_session<CR>", { desc = "Load last session" })
	end,
}
