return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python", -- Python
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio", -- Not needed here, but placeholder for others
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- DAP UI setup
		dapui.setup()

		-- Python (uses debugpy)
		require("dap-python").setup("python") -- Assumes `debugpy` is installed

		-- JavaScript/TypeScript/Node.js (uses Chrome or Node debug adapter)
		dap.adapters.node2 = {
			type = "executable",
			command = "node",
			args = { os.getenv("HOME") .. "/.local/share/nvim/dap/vscode-node-debug2/out/src/nodeDebug.js" },
		}
		dap.configurations.javascript = {
			{
				type = "node2",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
			},
		}
		dap.configurations.typescript = dap.configurations.javascript

		-- C++ (uses lldb or gdb)
		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-vscode",
			name = "lldb",
		}
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}

		-- Java (handled by jdtls, no extra config needed)

		-- Keybindings
		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F12>", dap.step_out)
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

		-- Auto-open DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}

