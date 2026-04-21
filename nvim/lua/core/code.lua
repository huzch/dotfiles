
vim.opt.autoindent = true --跟随上一行的缩进
vim.opt.smartindent = true --根据基本的语法结构缩进
vim.opt.shiftwidth = 4 --设置缩进宽度
vim.opt.tabstop = 4 --设置Tab宽度

vim.opt.backspace = "indent,eol,start" --更灵活的退格键

vim.opt.clipboard = "unnamedplus" --使用系统剪切板

vim.opt.signcolumn = "yes" --始终显示符号列
vim.opt.updatetime = 300 --更快的响应速度


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
