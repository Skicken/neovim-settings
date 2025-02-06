return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local has_treesitter_cli = vim.fn.executable("tree-sitter") == 1

		local parsers = {
			"c",
			"html",
			"css",
			"python",
			"typescript",
			"cpp",
			"lua",
			"vim",
			"vimdoc",
			"query",
		}

		if has_treesitter_cli then
			table.insert(parsers, "latex")
		end

		require("nvim-treesitter.configs").setup({
			ensure_installed = parsers,
			ignore_install = {},
			modules = {},
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
