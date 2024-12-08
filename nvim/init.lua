
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




--========= Disable =========

vim.opt.shortmess:append('I') --省略初始化信息

vim.opt.hidden = true --允许在不同缓冲区间自由切换，而不强制保存当前文件

vim.opt.errorbells = false --禁用错误铃声
vim.opt.visualbell = true --使用视觉铃声

vim.keymap.set('n', 'Q', '<Nop>', { noremap = true, silent = true })




--========= Plugin =========

-- 添加 lazy.nvim 插件到 runtimepath
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

-- 使用 lazy.nvim 管理插件
require('lazy').setup({
  'kien/ctrlp.vim',
  'jiangmiao/auto-pairs',
  'tpope/vim-commentary',

  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      -- 设置 coc.nvim 使用 clangd 作为 C++ 语言服务器
      vim.g.coc_global_extensions = { 'coc-clangd' }
    end
  },
})



