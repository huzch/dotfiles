return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"go", "gomod", "gosum",
				"typescript", "tsx", "javascript",
				"python",
				"c", "cpp",
				"rust",
				"lua", "vim", "vimdoc",
				"json", "yaml", "toml", "markdown", "markdown_inline",
				"bash", "html", "css",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
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
