return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"yamatsum/nvim-nonicons",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",

			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
	},
	config = function()
		local icons = require("nvim-nonicons")
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				defaults = {
					-- prompt_prefix = "  " .. icons.get("telescope") .. "  ",
					-- selection_caret = " ❯ ",
					-- entry_prefix = "   ",
					-- remember to have installed ripgrep
					file_ignore_patterns = { "vendor/", "build/", "node_modules/" },
				},
			},
			-- pickers = {
			-- 	find_files = {
			-- 		find_command = {
			-- 			"rg",
			-- 			"--files",
			-- 			"--hidden",
			-- 			"--glob",
			-- 			"!.vendor/",
			-- 			"--glob",
			-- 			"!build/",
			-- 		},
			-- 	},
			-- },
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local action_state = require('telescope.actions.state')

		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set('n', '<leader><leader>', function()
			builtin.buffers({
				initial_mode = "insert",
				attach_mappings = function(prompt_bufnr, map)
					local delete_buf = function()
						local current_picker = action_state.get_current_picker(prompt_bufnr)
						current_picker:delete_selection(function(selection)
							vim.api.nvim_buf_delete(selection.bufnr, { force = true })
						end)
					end
					map('n', 'x', delete_buf)
					return true
				end
			}, {
				sort_lastused = true,
				sort_mru = true,
				theme = "dropdown"
			})
		end)

		vim.keymap.set("n", "<C-s>", builtin.git_status)
	end,
}
