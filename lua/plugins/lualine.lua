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
						path = 1,
						color = { fg = colors.magenta, gui = "bold" },
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
							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
							local clients = vim.lsp.get_active_clients()
							if next(clients) == nil then
								return msg
							end
							local lsps_names = ""
							for _, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
									lsps_names = lsps_names .. " " .. client.name
								end
							end
							return lsps_names
						end,
						icon = " LSP:",
						color = { fg = "#ffffff", gui = "bold" },
					},
				},
				lualine_z = {},
			},
		}

		lualine.setup(config)
	end,
}
