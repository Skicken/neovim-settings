return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				cpp = { "clangd" },
			},

			vim.keymap.set("n", "<leader>ff", function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end, { desc = "format code" }),
		})
		require("conform").formatters.prettier = {
			prepend_args = { "--tab-width", "2" },
		}
		require("conform").formatters.clangd = {
			prepend_args = { "--falback-style", "{UseTab: Always,IndentWidth: 2,TabWidth: 2}" },
		}
	end,
}
