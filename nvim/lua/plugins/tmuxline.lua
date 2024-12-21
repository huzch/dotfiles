return {
	'edkolev/tmuxline.vim',
	config = function()
		if os.getenv("TMUX") then
			vim.cmd(':Tmuxline')
		end
	end
}
