return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

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

			local map = vim.keymap.set
			local opts = { noremap = true, silent = true }

			map("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
			map("n", "<F10>", ":lua require'dap'.step_over()<CR>", opts)
			map("n", "<F11>", ":lua require'dap'.step_into()<CR>", opts)
			map("n", "<F12>", ":lua require'dap'.step_out()<CR>", opts)
			map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Breakpoint" })
			map("n", "<leader>dr", ":lua require'dap'.repl.toggle()<CR>", { desc = "Toggle REPL" })
		end,
	},
}
