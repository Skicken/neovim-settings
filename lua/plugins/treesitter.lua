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

		vim.keymap.set("n", "dc", function()
			local ts = vim.treesitter
			local bufnr = vim.api.nvim_get_current_buf()
			local parser = ts.get_parser(bufnr)
			local tree = parser:parse()[1]
			local root = tree:root()
			local query = ts.query.parse(
				parser:lang(),
				[[
    (comment) @comment
  ]]
			)

			local comment_ranges = {}
			for id, node in query:iter_captures(root, bufnr, 0, -1) do
				if query.captures[id] == "comment" then
					local sr, sc, er, ec = node:range()
					table.insert(comment_ranges, { sr, sc, er, ec })
				end
			end

			table.sort(comment_ranges, function(a, b)
				if a[1] == b[1] then
					return a[2] > b[2]
				end
				return a[1] > b[1]
			end)

			for _, range in ipairs(comment_ranges) do
				local sr, sc, er, ec = unpack(range)
				if sr == er then
					local line = vim.api.nvim_buf_get_lines(bufnr, sr, sr + 1, false)[1]
					local new_line = line:sub(1, sc) .. line:sub(ec + 1)
					vim.api.nvim_buf_set_lines(bufnr, sr, sr + 1, false, { new_line })
				else
					local lines = vim.api.nvim_buf_get_lines(bufnr, sr, er + 1, false)
					lines[1] = lines[1]:sub(1, sc)
					lines[#lines] = lines[#lines]:sub(ec + 1)

					vim.api.nvim_buf_set_lines(bufnr, sr, er + 1, false, lines)
				end
			end
		end, { desc = "Delete all comments using Tree-sitter" })
	end,
}
