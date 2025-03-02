return {
	-- {
	-- 	'octol/vim-cpp-enhanced-highlight',
	-- 	config = function()
	-- 		vim.g.cpp_class_scope_highlight = 1
	-- 		vim.g.cpp_member_variable_highlight = 1
	-- 		vim.g.cpp_class_decl_highlight = 1
	-- 		vim.g.cpp_posix_standard = 1
	-- 		vim.g.cpp_experimental_simple_template_highlight = 1
	-- 		vim.g.cpp_experimental_template_highlight = 1
	-- 		vim.g.cpp_concepts_highlight = 1
	-- 	end
	-- },

	{
		'neoclide/coc.nvim',
		branch = 'release',
		event = "InsertEnter",
		config = function()
			local filetype = vim.bo.filetype
			if filetype == "cpp" then
				vim.g.coc_global_extensions = { 'coc-clangd' }
			elseif filetype == "python" then
				vim.g.coc_global_extensions = { 'coc-pyright' }
			end


			-- Some servers have issues with backup files, see #649
			vim.opt.backup = false
			vim.opt.writebackup = false

			-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
			-- delays and poor user experience
			vim.opt.updatetime = 300

			-- Always show the signcolumn, otherwise it would shift the text each time
			-- diagnostics appeared/became resolved
			vim.opt.signcolumn = "yes"

			local keyset = vim.keymap.set
			-- Autocomplete
			function _G.check_back_space()
				local col = vim.fn.col('.') - 1
				return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
			end

			-- Use Tab for trigger completion with characters ahead and navigate
			local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
			keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
			keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

			-- Make <CR> to accept selected completion item or notify coc.nvim to format
			-- <C-g>u breaks current undo, please make your own choice
			keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

			-- Use <c-j> to trigger snippets
			keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

			-- Use `[g` and `]g` to navigate diagnostics
			keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
			keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

			-- GoTo code navigation
			keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
			keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
			keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
			keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

			-- Use K to show documentation in preview window
			function _G.show_docs()
				local cw = vim.fn.expand('<cword>')
				if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
					vim.api.nvim_command('h ' .. cw)
				elseif vim.api.nvim_eval('coc#rpc#ready()') then
					vim.fn.CocActionAsync('doHover')
				else
					vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
				end
			end
			keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

			-- Symbol renaming
			keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

			-- Add `:Format` command to format current buffer
			vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

			-- " Add `:Fold` command to fold current buffer
			vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
		end
	},

	-- {
	-- 	"williamboman/mason.nvim", -- Mason 负责管理 LSP、DAP、格式化工具等
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		ui = {
	-- 			border = "rounded",
	-- 			icons = {
	-- 				package_installed = "✓",
	-- 				package_pending = "➜",
	-- 				package_uninstalled = "✗"
	-- 			}
	-- 		}
	-- 	}
	-- },
	--
	-- {
	-- 	"jay-babu/mason-lspconfig.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		automatic_installation = true,
	-- 		ensure_installed = { "clangd", "pyright" },
	-- 		handlers = {}
	-- 	}
	-- },
	--
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-nvim-lsp",  -- LSP 补全
	-- 		"hrsh7th/cmp-buffer",    -- 缓冲区补全
	-- 		"hrsh7th/cmp-path",      -- 文件路径补全
	-- 		"hrsh7th/cmp-cmdline",   -- 命令行补全
	-- 		"L3MON4D3/LuaSnip",      -- 片段引擎（可选）
	-- 		"saadparwaiz1/cmp_luasnip", -- 片段补全（可选）
	-- 	},
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		cmp.setup({
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					require("luasnip").lsp_expand(args.body) -- 需要安装 LuaSnip
	-- 				end,
	-- 			},
	-- 			mapping = {
	-- 				["<Space-Tab>"] = cmp.mapping.complete(),     -- 触发补全
	-- 				["<Tab>"] = cmp.mapping.confirm({ select = true }), -- 确认补全项
	-- 				["<C-j>"] = cmp.mapping.select_next_item(), -- 选择下一个
	-- 				["<C-k>"] = cmp.mapping.select_prev_item(), -- 选择上一个
	-- 			},
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" }, -- LSP 补全
	-- 				{ name = "buffer" },   -- 缓冲区补全
	-- 				{ name = "path" },     -- 文件路径补全
	-- 			}),
	-- 		})
	-- 	end,
	-- }
}
