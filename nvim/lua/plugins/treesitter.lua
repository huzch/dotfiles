return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
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
}
