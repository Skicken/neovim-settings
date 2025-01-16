return function()
	local ls = require("luasnip")
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node

	ls.add_snippets("tex", {
		s("lst", {
			t("\\begin{lstlisting}[caption={"),
			i(1, "Your caption here"),
			t("}, label={"),
			i(2, "lst:example"),
			t("},numbers=none]"),
			t({ "", "" }),
			i(3, "Your code here"),
			t({ "", "\\end{lstlisting}" }),
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
end
