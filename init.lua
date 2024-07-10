require("config.init")
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		{ import = "plugins.markdown-preview" },
		{ import = "plugins.lsp" },
	},
})
