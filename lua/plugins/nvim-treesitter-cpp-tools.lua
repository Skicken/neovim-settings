return {
	"Badhi/nvim-treesitter-cpp-tools",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- Optional: Configuration
	opts = function()
		local options = {
			preview = {
				quit = "<ESC>", -- optional keymapping for quit preview
				accept = "<CR>", -- optional keymapping for accept preview
			},
			header_extension = "hpp", -- optional
			source_extension = "cpp", -- optional
			custom_define_class_function_commands = { -- optional
				TSCppImplWrite = {
					output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
				},
				--[[
                <your impl function custom command name> = {
                    output_handle = function (str, context) 
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
			},
		}
		vim.keymap.set({ "n", "v" }, "<leader>mm", function()
			local base_name = vim.fn.expand("%:r") .. ".cpp"
			print("Moving definition to " .. base_name)
			if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
				vim.cmd("'<,'>TSCppDefineClassFunc")
			else
				vim.cmd("TSCppDefineClassFunc")
			end
			vim.cmd("edit " .. base_name)
			vim.cmd("$")
		end, { desc = "[M]ake [M]ethods", noremap = true, silent = true })
		return options
	end,
	config = true,
	-- End configuration
}
