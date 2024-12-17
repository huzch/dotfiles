return {
	'ibhagwan/fzf-lua',
	keys = {
		{ "<c-P>", ":FzfLua files<CR>", desc = "Fzf Files" },
	},
	config = function()
		require("fzf-lua").setup({})
	end
}
