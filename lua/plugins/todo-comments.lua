return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			FIX = {
				icon = " ",
				color = "error",
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
			},
			FEAT = { icon = " ", color = "info", alt = { "TODO", "FEAT" } },
			REFACTOR = { icon = " ", color = "default", alt = { "REFACTOR", "REFACT" } },
			CHORE = { icon = " ", color = "hint", alt = { "CHORE", "MAINTENANCE" } },
			BUILD = { icon = " ", color = "hint", alt = { "BUILD", "COMPILATION" } },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)
		vim.keymap.set("n", "T", ":TodoTelescope<CR>")
	end,
}
