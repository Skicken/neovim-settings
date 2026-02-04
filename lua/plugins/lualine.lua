return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/noice.nvim" },
	config = function()
		local lualine = require("lualine")
		local colors = {
			bg = "#202328",
			fg = "#bbc2cf",
			yellow = "#ECBE7B",
			cyan = "#008080",
			darkblue = "#081633",
			green = "#98be65",
			orange = "#FF8800",
			violet = "#a9a1e1",
			magenta = "#c678dd",
			blue = "#51afef",
			red = "#ec5f67",
		}

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}
		local config = {
			options = {
				-- Disable sections and component separators
				disabled_filetypes = { "neo-tree", "NvimTree", "^neo%-tree.*" },
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				theme = "auto",
			},
			sections = {
				-- these are to remove the defaults
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { fg = colors.violet, gui = "bold" },
					},
					{
						"diff",
						-- Is it me or the symbol for modified us really weird
						symbols = { added = " ", modified = "󰝤 ", removed = " " },
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.orange },
							removed = { fg = colors.red },
						},
						cond = conditions.hide_in_width,
					},
				},
				lualine_c = {
					{
						"filename",
						path = 0,
						color = { fg = colors.magenta },
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " " },
						diagnostics_color = {
							color_error = { fg = colors.red },
							color_warn = { fg = colors.yellow },
							color_info = { fg = colors.cyan },
						},
					},
				},
				-- These will be filled later
				lualine_x = {
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.search.get,
						cond = require("noice").api.status.search.has,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_y = {
					{
						-- Lsp server name .
						function()
							local msg = "No Active Lsp"
							local clients = vim.lsp.get_clients()
							if next(clients) == nil then
								return msg
							end
							local lsps_names = {}
							for _, client in ipairs(clients) do
								table.insert(lsps_names, client.name)
							end
							return table.concat(lsps_names, ", ")
						end,
						icon = ":",
						color = { fg = "#ffffff" },
					},
					{
						function()
							local status, conform = pcall(require, "conform")
							if not status then
								return "Conform not installed"
							end

							local formatters = conform.list_formatters_for_buffer()

							if formatters and #formatters > 0 then
								local formatters_names = {}

								for _, formatter in ipairs(formatters) do
									table.insert(formatters_names, formatter)
								end

								return table.concat(formatters_names, ", ")
							end

							return ""
						end,
						icon = ":",
						color = { fg = "#ffffff" },
					},
					{
						function()
							local status, lint = pcall(require, "lint")
							if not status then
								return "Lint not installed"
							end

							local linters = lint.linters_by_ft[vim.bo.filetype] or {}

							if #linters == 0 then
								return ""
							end

							return table.concat(linters, ", ")
						end,
						icon = ":",
						color = { fg = "#ffffff", gui = "bold" },
					},
				},
				lualine_z = {},
			},
		}

		lualine.setup(config)
	end,
}
