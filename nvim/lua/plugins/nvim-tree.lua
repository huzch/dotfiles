return {
	'nvim-tree/nvim-tree.lua',
	keys = {
		{ "<leader>nt", ":NvimTreeToggle<CR>",   desc = "Toggle NvimTree" },
		{ "<leader>nf", ":NvimTreeFindFile<CR>", desc = "Find current file in NvimTree" },
	},
	config = function()
		require("nvim-tree").setup({
			filters = { dotfiles = true },
			git = { ignore = true },
			update_focused_file = { enable = true, update_cwd = true },
			renderer = {
				icons = {
					show = { git = false, folder = false, file = false, folder_arrow = true },
					glyphs = {
						folder = { arrow_closed = "▸", arrow_open = "▾" },
					},
				},
			},
		})
	end
}
