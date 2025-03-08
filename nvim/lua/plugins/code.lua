return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
	},

	{
		'numToStr/Comment.nvim',
		event = "VeryLazy",
		config = function()
			local ft = require('Comment.ft')
			require('Comment').setup({})
			ft.set('c',  '// %s')
			ft.set('cpp', '// %s')
		end,
	},

	{
		'kylechui/nvim-surround',
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end
	},

	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		event = "VeryLazy",
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = { 'cpp', 'lua', 'markdown' },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},

				-- 增量选择
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						node_decremental = "<BS>",
					},
				},

				indent = {
					enable = true,
				},
			})
		end
	},

	-- {
	-- 	'iamcco/markdown-preview.nvim',
	-- 	build = 'cd app && npm install',
	-- 	ft = 'markdown',
	-- 	keys = {
	-- 		{ "<leader>md", ":MarkdownPreviewToggle<CR>", desc = "Toggle MarkdownPreview" },
	-- 	},
	-- 	config = function()
	-- 		vim.g.mkdp_auto_start = 1
	-- 		vim.g.mkdp_auto_close = 1
	-- 	end,
	-- },

	{
		"OXY2DEV/markview.nvim",
		lazy = false
	},
}
