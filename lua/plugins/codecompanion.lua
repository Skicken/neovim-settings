return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	enable = true,
	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					-- Change the default icons
					icons = {
						pinned_buffer = " ",
						watched_buffer = "👀 ",
					},

					-- Alter the sizing of the debug window
					debug_window = {
						---@return number|fun(): number
						width = vim.o.columns - 5,
						---@return number|fun(): number
						height = vim.o.lines - 2,
					},

					-- Options to customize the UI of the chat buffer
					window = {
						layout = "vertical", -- float|vertical|horizontal|buffer
						position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
						border = "single",
						height = 0.8,
						width = 0.4,
						relative = "editor",
						opts = {
							breakindent = true,
							cursorcolumn = false,
							cursorline = false,
							foldcolumn = "0",
							linebreak = true,
							list = false,
							numberwidth = 1,
							signcolumn = "no",
							spell = false,
							wrap = true,
						},
					},

				},
			},
			strategies = {
				chat = {
					adapter = "copilot",
					position = "right",
				},
				inline = {
					adapter = "copilot",
				},
			},
		})
		vim.keymap.set("n", "<leader>[", function()
			vim.cmd("CodeCompanionChat")
		end, { desc = "CodeCompanionChat" })

		vim.keymap.set("n", "<leader>]", function()
			vim.cmd("CodeCompanionActions")
		end, { desc = "description" })
	end,
}
