return function()
	local ls = require("luasnip")
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

	ls.add_snippets("tex", {
		s("lst", {
			t("\\begin{listing}[H]"),
			t({ "", "\\begin{minted}{" }),
			i(1, "language"),
			t("}"),
			t({ "", "" }),
			i(2, "Your code here"),
			t({ "", "\\end{minted}" }),
			t({ "", "\\caption{" }),
			i(3, "Your caption here"),
			t("}"),
			t({ "", "\\label{" }),
			i(4, "listing:example"),
			t("}"),
			t({ "", "\\end{listing}" }),
		}),
	})

	ls.add_snippets("tex", {
		s("img", {
			t("\\begin{figure}[H]"),
			t({ "", "    \\centering" }),
			t({ "", "    \\includegraphics[width=" }),
			i(1, "0.8\\textwidth"), -- Parameter for image width
			t("]{"),
			i(2, "path/to/image"), -- Parameter for image path
			t("}"),
			t({ "", "    \\caption{" }),
			i(3, "Your caption here"), -- Parameter for caption
			t("}"),
			t({ "", "    \\label{" }),
			i(4, "fig:example"), -- Parameter for label
			t("}"),
			t({ "", "\\end{figure}" }),
		}),
	})

	ls.add_snippets("lua", {
		s("vimkeycmd", {
			t('vim.keymap.set("n","'),
			i(1, "keymap"),
			t({ '",function()', 'vim.cmd("' }),
			i(2, "command"),
			t({ '")', 'end,{desc="' }),
			i(3, "description"),
			t('"})'),
		}),
	})
	ls.add_snippets("cpp", {
		s("gtest", {
			t("TEST("),
			i(1, "TestSuite"),
			t(", "),
			i(2, "TestName"),
			t(") {"),
			t({ "", "}" }),
		}),
	})
end
