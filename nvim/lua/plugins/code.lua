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
		"OXY2DEV/markview.nvim",
		lazy = false
	},
}
