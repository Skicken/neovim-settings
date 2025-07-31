return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },

	config = function()
		require("dapui").setup({
			controls = {
				element = "repl",
				enabled = false,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "right",
					size = 40,
				},
				{
					elements = {},
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})

		local dap, dapui = require("dap"), require("dapui")
		require("nvim-dap-virtual-text").setup()

		vim.keymap.set("n", "<leader>tr", dap.toggle_breakpoint, { desc = "[T]oggle B[R]eakpoint" })
		vim.keymap.set("n", "<leader>gc", dap.run_to_cursor, { desc = "(Dap) Run to cursor" })
		vim.keymap.set("n", "<leader>,", function()
			dapui.eval(nil, { enter = true })
		end, { desc = "description" })

		vim.keymap.set("n", "<leader>1", dap.continue, { desc = "Debugger continue" })
		vim.keymap.set("n", "<leader>2", dap.step_over, { desc = "Debugger step over" })
		vim.keymap.set("n", "<leader>3", dap.step_into, { desc = "Debugger step into" })
		vim.keymap.set("n", "<leader>4", dap.step_out, { desc = "Debugger step out" })
		vim.keymap.set("n", "<leader>5", dap.step_over, { desc = "Debugger step over" })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}
		local c_cpp_config = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.cpp = c_cpp_config
		dap.configurations.c = c_cpp_config
	end,
}
