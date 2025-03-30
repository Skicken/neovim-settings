return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },

	config = function()
		require("dapui").setup()

		local dap, dapui = require("dap"), require("dapui")
		require("nvim-dap-virtual-text").setup()

		vim.keymap.set("n", "<C-b>", dap.toggle_breakpoint, { desc = "Toggle brekapoint" })
		vim.keymap.set("n", "<C-g>", dap.run_to_cursor, { desc = "Run to cursor" })
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
		local c_cpp_config = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
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
