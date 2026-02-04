return {

	"https://github.com/mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			python = { "ruff" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			lua = { "luacheck" },
			markdown = { "markdownlint" },
			yaml = { "yamllint" },
			["*"] = { "codespell" },
		}
	end,
}
