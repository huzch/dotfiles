
vim.opt.shortmess:append('I') --省略初始化信息

vim.opt.hidden = true --允许在不同缓冲区间自由切换，而不强制保存当前文件

vim.opt.errorbells = false --禁用错误铃声
vim.opt.visualbell = true --使用视觉铃声

vim.opt.showmode = false --禁用模式信息

vim.keymap.set('n', 'Q', '<Nop>', { noremap = true, silent = true })
