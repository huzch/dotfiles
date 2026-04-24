return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
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
		},
		config = function(_, opts)
			local ts = require("nvim-treesitter")
			local ts_config = require("nvim-treesitter.config")

			ts.setup({})

			local installed = ts_config.get_installed("parsers")
			local missing = vim.tbl_filter(function(lang)
				return not vim.list_contains(installed, lang)
			end, opts.ensure_installed)

			if #missing > 0 then
				ts.install(missing)
			end

			local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = {
					"go", "gomod", "gosum",
					"typescript", "typescriptreact", "javascript", "javascriptreact",
					"python",
					"c", "cpp",
					"rust",
					"lua", "vim",
					"json", "yaml", "toml", "markdown",
					"sh", "html", "css",
				},
				callback = function(args)
					if vim.bo[args.buf].buftype ~= "" then
						return
					end

					pcall(vim.treesitter.start, args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
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
