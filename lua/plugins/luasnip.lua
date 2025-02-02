return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.3", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		vim.keymap.set({ "i" }, "<C-K>", function()
			ls.expand()
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-n>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-p>", function()
			ls.jump(-1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })
		require("luasnip.loaders.from_vscode").lazy_load()
		require("plugins-config.snippets.snippets")()
	end,
}
