return {
	'neoclide/coc.nvim',
	branch = 'release',
	config = function()
		local filetype = vim.bo.filetype
		if filetype == "cpp" then
			vim.g.coc_global_extensions = { 'coc-clangd' }
		end

		-- 补全选择
		vim.keymap.set("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]], { expr = true, silent = true })
		vim.keymap.set("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true, silent = true })
		vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], { expr = true, silent = true })

		-- 导航诊断
		vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
		vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

		-- 导航代码
		vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
		vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
		vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
		vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })

		-- 文档显示
		function _G.show_docs()
			local cw = vim.fn.expand('<cword>')
			if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
				vim.api.nvim_command('h ' .. cw)
			elseif vim.api.nvim_eval('coc#rpc#ready()') then
				vim.fn.CocActionAsync('doHover')
			else
				vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
			end
		end
		vim.keymap.set("n", "<leader>d", '<CMD>lua _G.show_docs()<CR>', { silent = true })

		-- 重命名与格式化
		vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
		vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
		vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
		vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
	end
}