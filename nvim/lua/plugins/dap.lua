return {
	{
		'mfussenegger/nvim-dap',
		ft = 'cpp',
		config = function()
			local dap = require('dap')

			dap.adapters.gdb = {
				type = 'executable',
				command = 'gdb',
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}

			dap.configurations.cpp = {
				{
					name = 'Debug C++',
					type = 'gdb',
					request = 'launch',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
				},
			}

			vim.keymap.set('n', '<F5>', dap.continue, { noremap = true, silent = true })
			vim.keymap.set('n', '<F10>', dap.step_over, { noremap = true, silent = true })
			vim.keymap.set('n', '<F11>', dap.step_into, { noremap = true, silent = true })
			vim.keymap.set('n', '<F12>', dap.step_out, { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { noremap = true, silent = true })
			vim.keymap.set('n', '<leader>r', dap.repl.toggle, { noremap = true, silent = true })
		end,
	},

	{
		'rcarriga/nvim-dap-ui',
		ft = 'cpp',
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require('dapui')
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "watches", size = 0.7 }, -- 监视窗口占右侧的上半部分
							-- { id = "repl",    size = 0.3 }, -- REPL 窗口占右侧的下半部分
						},
						size = 40,      -- 设置右侧总宽度，单位是列数
						position = "right", -- 将布局放在右侧
					},
				},
			})

			local dap = require("dap")
			-- 在启动调试会话前打开 UI
			dap.listeners.before['event_initialized']['dapui_config'] = function()
				dapui.open()
			end

			-- 在调试会话启动前打开 UI
			dap.listeners.before['event_launch']['dapui_config'] = function()
				dapui.open()
			end

			-- 在调试会话终止时关闭 UI
			dap.listeners.before['event_terminated']['dapui_config'] = function()
				dapui.close()
			end

			-- 在调试会话退出时关闭 UI
			dap.listeners.before['event_exited']['dapui_config'] = function()
				dapui.close()
			end
		end,
	},
}
