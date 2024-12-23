return {
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
	},

	{
		'numToStr/Comment.nvim',
		event = "VeryLazy",
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
				ensure_installed = { 'cpp', 'lua' },
				highlight = {
					enable = false,
					additional_vim_regex_highlighting = false,
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

	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && npm install',
		ft = 'markdown',
		keys = {
			{"<leader>md", ":MarkdownPreviewToggle<CR>", desc = "Toggle MarkdownPreview"},
		},
		config = function()
			vim.g.mkdp_auto_start = 1
			vim.g.mkdp_auto_close = 1
		end,
	},
}
