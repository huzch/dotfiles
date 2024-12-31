
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

-- 快速跳至上下10行
vim.keymap.set('n', 'K', '10k', { noremap = true , silent = true })
vim.keymap.set('n', 'J', '10j', { noremap = true , silent = true })
vim.keymap.set('v', 'K', '10k', { noremap = true , silent = true })
vim.keymap.set('v', 'J', '10j', { noremap = true , silent = true })

-- 快速窗格选择
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true , silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true , silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true , silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true , silent = true })

