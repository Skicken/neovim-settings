return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "ruff", "black", "isort" },
				-- Use a sub-list to run only the first available formatter
				cpp = { "clang-format" },
				go = { "gofmt" },
				java = { "google-java-format" },
				["vue"] = { "eslint_d" },
				["*"] = { "codespell" },
			},

			vim.keymap.set("n", "<leader>ff", function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end, { desc = "format code" }),
		})
	end,
}
