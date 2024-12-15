					
--========= Code =========

vim.opt.autoindent = true --跟随上一行的缩进
vim.opt.smartindent = true --根据基本的语法结构缩进
vim.opt.shiftwidth = 4 --设置缩进宽度
vim.opt.tabstop = 4 --设置Tab宽度

vim.opt.backspace = "indent,eol,start" --更灵活的退格键

vim.opt.clipboard = "unnamedplus" --使用系统剪切板

-- 用 Ctrl+o 代替 Esc
vim.keymap.set('i', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('s', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('x', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('c', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('o', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('l', '<C-o>', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-o>', '<Esc>', { noremap = true, silent = true })



-- 设置 leader 键
vim.g.mapleader = " "

-- 快速保存、退出
vim.keymap.set('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>wq', ':wq<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>Q', ':q!<CR>', { noremap = true, silent = true })

-- 快速格式化代码
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- 快速分割窗口
vim.keymap.set('n', '|', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '-', ':split<CR>', { noremap = true, silent = true })




--========= Move =========

vim.opt.number = true --显示行号
vim.opt.relativenumber = true --显示相对行号
vim.opt.laststatus = 2 --设置常驻状态栏

vim.opt.ignorecase = true --默认不区分大小写搜索
vim.opt.smartcase = true --搜索时若出现大写则区分大小写
vim.opt.incsearch = true --启用增量搜索
vim.opt.hlsearch = true --高亮搜索匹配项

-- 禁用新手拐杖
vim.keymap.set('n', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<Right>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<Right>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('v', '<Up>', '<Nop>', { noremap = true, silent = true })

-- 快速跳至行首和行尾
vim.keymap.set('n', 'H', '^', { noremap = true , silent = true })
vim.keymap.set('n', 'L', '$', { noremap = true , silent = true })

-- 快速窗格选择
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true , silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true , silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true , silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true , silent = true })




--========= Disable =========

vim.opt.shortmess:append('I') --省略初始化信息

vim.opt.hidden = true --允许在不同缓冲区间自由切换，而不强制保存当前文件

vim.opt.errorbells = false --禁用错误铃声
vim.opt.visualbell = true --使用视觉铃声

vim.opt.showmode = false --禁用模式信息

vim.keymap.set('n', 'Q', '<Nop>', { noremap = true, silent = true })




--========= Plugin =========

-- 自动安装 lazy.nvim 插件管理器 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 使用 lazy.nvim 管理插件
require('lazy').setup({
	defaults = {
		event = "VimEnter", --统一延迟加载所有插件，直到 Vim 启动完成
	},
	
	'jiangmiao/auto-pairs',
	'tpope/vim-commentary',
	'gcmt/wildfire.vim',
	'tpope/vim-surround',

	{
		'joshdick/onedark.vim',
		config = function()
			vim.cmd('colorscheme onedark')
		end
	},

	{
		'itchyny/lightline.vim',
		config = function()
			vim.cmd('colorscheme onedark')
		end
	},

	{
		'edkolev/tmuxline.vim',
		config = function()
			vim.cmd(':Tmuxline')
		end
	},

	{
		'octol/vim-cpp-enhanced-highlight',
		config = function()
			vim.g.cpp_class_scope_highlight = 1
			vim.g.cpp_member_variable_highlight = 1
			vim.g.cpp_class_decl_highlight = 1
			vim.g.cpp_posix_standard = 1
			vim.g.cpp_experimental_simple_template_highlight = 1
			vim.g.cpp_experimental_template_highlight = 1
			vim.g.cpp_concepts_highlight = 1
		end
	},

	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = { "cpp", "lua" },

				-- 语法高亮
				highlight = {
					enable = false,
					additional_vim_regex_highlighting = false, -- 禁用额外的 Vim 正则表达式高亮
				},

				-- 增量选择
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>", -- 初始化选择
						node_incremental = "<CR>", -- 增加选择
						node_decremental = "<BS>", -- 减少选择
					},
				},

				-- 自动缩进
				indent = {
					enable = true,
				},
			}
		end
	},

	{
		"junegunn/fzf",
		build = "./install --bin"
	},


	{
		"ibhagwan/fzf-lua",
		keys = {
			{ "<c-P>", ":FzfLua files<CR>", desc = "Fzf Files" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({})
		end
	},

	{
		'nvim-tree/nvim-tree.lua',
		keys = {
			{ "<leader>nt", ":NvimTreeToggle<CR>",   desc = "Toggle NvimTree" },
			{ "<leader>nf", ":NvimTreeFindFile<CR>", desc = "Find current file in NvimTree" },
		},
		dependencies = { 'nvim-tree/nvim-web-devicons' }, -- 图标支持
		config = function()
			require("nvim-tree").setup({
				-- 文件过滤器
				filters = {
					dotfiles = true,
				},

				git = {
					ignore = true,
				},

				update_focused_file = {
					enable = true,
					update_cwd = true,
				},

				-- 文件图标
				renderer = {
					icons = {
						show = {
							git = false,
							folder = false,
							file = false,
							folder_arrow = true,
						},
						glyphs = {
							default = "📄", -- 默认文件图标
							symlink = "🔗", -- 符号链接文件图标
							folder = { -- 文件夹相关图标
								arrow_closed = "▸", -- 关闭状态的箭头图标
								arrow_open = "▾", -- 打开状态的箭头图标
								default = "📁", -- 默认文件夹图标
								open = "📂", -- 打开状态的文件夹图标
								empty = "🗀", -- 空文件夹图标
								empty_open = "🗁", -- 打开状态的空文件夹图标
								symlink = "🔗", -- 符号链接文件夹图标
								symlink_open = "🔗", -- 打开状态的符号链接文件夹图标
							},
						},
					},
				},
			})
		end
    },

	{
		"nvim-tree/nvim-web-devicons", -- 图标插件
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					lua = { icon = "🌙", color = "#51a0cf", cterm_color = "74", name = "Lua" },
					html = { icon = "🌐", color = "#e34c26", cterm_color = "196", name = "Html" },
					css = { icon = "🎨", color = "#563d7c", cterm_color = "60", name = "Css" },
					js = { icon = "📜", color = "#f1e05a", cterm_color = "220", name = "Js" },
					json = { icon = "📊", color = "#f44d27", cterm_color = "202", name = "Json" },
					md = { icon = "📖", color = "#519aba", cterm_color = "67", name = "Markdown" },
					txt = { icon = "📄", color = "#89e051", cterm_color = "113", name = "Text" },
					sh = { icon = "📝", color = "#4caf50", cterm_color = "65", name = "ShellScript" },
					cpp = { icon = "🌟", color = "#29b6f6", cterm_color = "33", name = "Cpp" },
				},
				default = true, -- 启用默认图标
			})
		end,
	},

	{
		'neoclide/coc.nvim',
		branch = 'release',
		-- ft = "cpp",
		-- cmd = "CocInstall",
		config = function()
			local filetype = vim.bo.filetype

			if filetype == "cpp" then
				-- 设置 coc.nvim 使用 clangd 作为 C++ 语言服务器
				vim.g.coc_global_extensions = { 'coc-clangd' }
			end

			-- 使用 <Tab> 和 <Shift-Tab> 进行补全选择
			vim.keymap.set("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]], { expr = true, silent = true })
			vim.keymap.set("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { expr = true, silent = true })

			-- 确认补全
			vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], { expr = true, silent = true })

			-- 导航诊断
			vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
			vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

			-- 导航代码
			vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
			vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
			vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
			vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})

			-- 显示文档
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
			vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

			-- 重命名符号
			vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

			-- 格式化代码
			vim.keymap.set("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
			vim.keymap.set("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
			vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
		end
	},
})



