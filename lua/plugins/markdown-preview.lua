return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && npm install",
	init = function()
		local g = vim.g
		g.mkdp_auto_start = 0
		g.mkdp_auto_close = 1
		g.mkdp_refresh_slow = 1

		g.mkdp_filetypes = { "markdown" }
		g.mkdp_page_title = "${name}.md"
		g.mkdp_preview_options = {
			disable_sync_scroll = 0,
			disable_filename = 1,
		}
	end,
}
