return
{
	"xiyaowong/transparent.nvim",
	config = function()
		vim.keymap.set("n","<leader>tc",":TransparentToggle<CR>",{desc="Toggle transparency"})
    end,
}
