return {
	"t-troebst/perfanno.nvim",
	dependensies = {
		"nvim-telescope/telescope.nvim",
	},

	config = function()
		local perfanno = require("perfanno")
		local util = require("perfanno.util")
		perfanno.setup({
			line_highlights = util.make_bg_highlights(nil, "#CC3300", 10),
			vt_highlight = util.make_fg_highlight("#CC3300"),
			formats = {
				{ percent = true, format = "%.2f%%", minimum = 0.5 },
				{ percent = false, format = "%d", minimum = 1 },
			},

			-- Automatically annotate files after :PerfLoadFlat and :PerfLoadCallGraph
			annotate_after_load = true,
			-- Automatically annotate newly opened buffers if information is available
			annotate_on_open = true,

			-- Options for telescope-based hottest line finders
			telescope = {
				-- Enable if possible, otherwise the plugin will fall back to vim.ui.select
				enabled = pcall(require, "telescope"),
				-- Annotate inside of the preview window
				annotate = true,
			},

			-- Node type patterns used to find the function that surrounds the cursor
			ts_function_patterns = {
				-- These should work for most languages (at least those used with perf)
				default = {
					"function",
					"method",
				},
				-- Otherwise you can add patterns for specific languages like:
				-- weirdlang = {
				--     "weirdfunc",
				-- }
			},
		})
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>plf", ":PerfLoadFlat<CR>", opts)
		vim.keymap.set("n", "<leader>plg", ":PerfLoadCallGraph<CR>", opts)
		vim.keymap.set("n", "<leader>plo", ":PerfLoadFlameGraph<CR>", opts)
		vim.keymap.set("n", "<leader>pe", ":PerfPickEvent<CR>", opts)
		vim.keymap.set("n", "<leader>pa", ":PerfAnnotate<CR>", opts)
		vim.keymap.set("n", "<leader>pf", ":PerfAnnotateFunction<CR>", opts)
		vim.keymap.set("v", "<leader>pa", ":PerfAnnotateSelection<CR>", opts)
		vim.keymap.set("n", "<leader>pt", ":PerfToggleAnnotations<CR>", opts)
		vim.keymap.set("n", "<leader>ph", ":PerfHottestLines<CR>", opts)
		vim.keymap.set("n", "<leader>ps", ":PerfHottestSymbols<CR>", opts)
		vim.keymap.set("n", "<leader>pc", ":PerfHottestCallersFunction<CR>", opts)
		vim.keymap.set("v", "<leader>pc", ":PerfHottestCallersSelection<CR>", opts)
		local telescope = require("telescope")
		local actions = telescope.extensions.perfanno.actions

		telescope.setup({
			extensions = {
				perfanno = {
					-- Special mappings in the telescope finders
					mappings = {
						["i"] = {
							-- Find hottest callers of selected entry
							["<C-h>"] = actions.hottest_callers,
							-- Find hottest callees of selected entry
							["<C-l>"] = actions.hottest_callees,
						},

						["n"] = {
							["gu"] = actions.hottest_callers,
							["gd"] = actions.hottest_callees,
						},
					},
				},
			},
		})
	end,
}
