return {
	{
		"mfussenegger/nvim-dap",
        event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dap-vscode-js").setup({
				-- Path to node executable. Defaults to "node"
				-- node_path = "node",

				-- Path to debugger optimized for VS Code
				-- debugger_path = "(runtimedir)/lazy/nvim-dap-vscode-js/dist/src/dapDebugServer.js",

				-- debugger_cmd = { "node", "C:/Users/me/Desktop/dap/dist/src/dapDebugServer.js" },
				adapters = {
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"node-terminal",
					"pwa-extensionHost",
				},
			})

			require("dapui").setup()
			require("dap-go").setup()

			-- Setup for other languages
			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

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

			map("n", "<F5>", function() dap.continue() end, opts)
			map("n", "<F10>", function() dap.step_over() end, opts)
			map("n", "<F11>", function() dap.step_into() end, opts)
			map("n", "<F12>", function() dap.step_out() end, opts)
			map("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Breakpoint" })
			map("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
		end,
	},
}
