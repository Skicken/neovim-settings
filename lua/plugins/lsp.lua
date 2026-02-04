return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	version = "1.8.0",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "mason-org/mason.nvim", config = true, branch = "v1.x" },
		{ "williamboman/mason-lspconfig.nvim", branch = "v1.x" },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{ "j-hui/fidget.nvim", opts = {} },

		-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		{ "folke/lazydev.nvim", opts = {} },
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local telescope = require("telescope.builtin")
				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", telescope.lsp_definitions, "[G]oto [D]definition")

				-- Find references for the word under your cursor.
				map("gr", telescope.lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", telescope.lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>D", telescope.lsp_type_definitions, "Type [D]definition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]symbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]symbols")

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap.
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- The following autocommand is used to enable inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local ok = pcall(require, "mason-registry")
		if not ok then
			vim.notify("mason-registry could not be loaded")
			return
		end
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local lsp_servers = {
			["html-lsp"] = {},
			["css-lsp"] = {},
		}
		local linters_formatters = {}

		if vim.fn.executable("lua") == 1 then
			linters_formatters["stylua"] = {}
			linters_formatters["luacheck"] = {}
			lsp_servers["lua_ls"] = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			}
		end
		if vim.fn.executable("ansible") == 1 then
			lsp_servers["ansible-lint"] = {}
			lsp_servers["ansible-language-server"] = {}
		end

		if vim.fn.executable("g++") == 1 then
			lsp_servers["clangd"] = {}
			linters_formatters["clang-format"] = {}
		end

		if vim.fn.executable("cmake") == 1 then
			lsp_servers["cmake"] = {}
		end

		if vim.fn.executable("docker") == 1 then
			lsp_servers["dockerls"] = {}
		end

		if vim.fn.executable("node") == 1 then
			lsp_servers["tailwindcss-language-server"] = {
				filetypes = { "css", "scss", "less", "html", "vue" },
			}
			lsp_servers["vtsls"] = {}
			lsp_servers["angular-language-server"] = {}
			lsp_servers["volar"] = {}
			linters_formatters["prettierd"] = {}
			linters_formatters["eslint"] = {}
		end

		if vim.fn.executable("tex") == 1 then
			lsp_servers["texlab"] = {}
		end

		if vim.fn.executable("java") == 1 then
			lsp_servers["jdtls"] = {
				cmd = { "jdtls" },
				root_dir = function(fname)
					return require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }, fname)
				end,
				settings = {
					java = {
						format = {
							settings = {
								url = vim.fn.stdpath("config") .. "/lsp/java-google-style.xml",
							},
						},
					},
				},
			}
			require("java").setup()
		end

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(lsp_servers or {})
		vim.list_extend(ensure_installed, vim.tbl_keys(linters_formatters or {}))

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server = lsp_servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
