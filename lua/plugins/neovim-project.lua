return {
	"coffebar/neovim-project",
	opts = {

		projects = { -- define project roots
			"~/dev/*",
			"~/.config/nvim/",
		},
		picker = {
			type = "telescope", -- or "fzf-lua"
		},

		last_session_on_startup = false,
		dashboard_mode = true,
	},
	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.

		vim.keymap.set("n", "<leader>sp", function()
			vim.cmd("NeovimProjectDiscover")
		end, { desc = "List sessions" })
		vim.keymap.set("n", "<leader>sl",function ()
			vim.cmd("NeovimProjectLoadRecent")
		end, { desc = "Load last session" })
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
		{ "Shatur/neovim-session-manager" },
	},
	-- config = function()
	-- end,
}
