return {
	{
		"folke/tokyonight.nvim"
	},

	{
		'itchyny/lightline.vim',
		config = function()
			vim.cmd('colorscheme tokyonight')
		end
	},

	{
		'edkolev/tmuxline.vim',
		config = function()
			if os.getenv("TMUX") then
				vim.cmd(':Tmuxline')
			end
		end
	},

	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				-- NOTE: this requires a version of yazi that includes
				-- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
				'<c-up>',
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = '<f1>',
			},
		},
	},

	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20, -- 终端窗口的大小
				open_mapping = [[<C-\>]], -- 绑定打开/关闭终端的快捷键
				hide_numbers = true, -- 隐藏行号
				shade_terminals = true, -- 终端背景颜色
				shading_factor = 2, -- 颜色深度
				start_in_insert = true, -- 默认进入插入模式
				insert_mappings = true, -- 允许在插入模式使用快捷键
				terminal_mappings = true, -- 允许在终端模式使用快捷键
				direction = "float", -- 终端方向，可选："horizontal"、"vertical"、"float"、"tab"
				close_on_exit = true, -- 终端进程退出时自动关闭
				shell = vim.o.shell, -- 使用 Neovim 的默认 shell
				float_opts = {
					border = "curved", -- 边框样式，可选："single"、"double"、"shadow"、"curved"
					winblend = 30, -- 透明度
				},
			})
		end
	}

	-- {
	-- 	'nvim-tree/nvim-tree.lua',
	-- 	keys = {
	-- 		{ "<leader>nt", ":NvimTreeToggle<CR>",   desc = "Toggle NvimTree" },
	-- 		{ "<leader>nf", ":NvimTreeFindFile<CR>", desc = "Find current file in NvimTree" },
	-- 	},
	-- 	config = function()
	-- 		require("nvim-tree").setup({
	-- 			filters = { dotfiles = true },
	-- 			git = { ignore = true },
	-- 			update_focused_file = { enable = true, update_cwd = true },
	-- 			renderer = {
	-- 				icons = {
	-- 					show = { git = false, folder = false, file = false, folder_arrow = true },
	-- 					glyphs = {
	-- 						folder = { arrow_closed = "▸", arrow_open = "▾" },
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end
	-- },
}
