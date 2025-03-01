return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")
			vim.keymap.set("n", "<F5>", dap.continue, { noremap = true, silent = true })
			vim.keymap.set("n", "<F10>", dap.step_over, { noremap = true, silent = true })
			vim.keymap.set("n", "<F11>", dap.step_into, { noremap = true, silent = true })
			vim.keymap.set("n", "<F12>", dap.step_out, { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { noremap = true, silent = true })

			vim.fn.sign_define("DapBreakpoint", {
				text = "",
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapBreakpointRejected", {
				text = "", -- or "❌"
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})

			vim.fn.sign_define("DapStopped", {
				text = "", -- or "→"
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticSignWarn",
			})
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require("dapui")
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "console", size = 0.3 }, -- 控制台占右侧的下半部分
							{ id = "watches", size = 0.7 }  -- 监视窗口占右侧的上半部分
						},
						size = 40,      -- 设置右侧总宽度
						position = "right",
					},
				},
			})

			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.keymap.set('n', '<leader>c', function()
				require("dapui").float_element("console", { enter = true })
			end, { noremap = true, silent = true, desc = "Toggle Floating Debug Console" })
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		event = "VeryLazy",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},

	{
		"williamboman/mason.nvim", -- Mason 负责管理 LSP、DAP、格式化工具等
		event = "VeryLazy",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		opts = {
			automatic_installation = true,
			ensure_installed = { "codelldb" },
			handlers = {}
		}
	},
}
