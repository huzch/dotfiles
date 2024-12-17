--========= Core =========

require('core')

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
require('lazy').setup(require('plugins'))

