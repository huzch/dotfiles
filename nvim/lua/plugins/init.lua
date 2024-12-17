local plugins = {
    require('plugins.vim-surround'),
    require('plugins.treesitter'),
}

if not vim.g.vscode then
    table.insert(plugins, require('plugins.auto-pairs'))
    table.insert(plugins, require('plugins.vim-commentary'))
    table.insert(plugins, require('plugins.onedark'))
    table.insert(plugins, require('plugins.lightline'))
    table.insert(plugins, require('plugins.tmuxline'))
    table.insert(plugins, require('plugins.cpp-enhanced-highlight'))
    table.insert(plugins, require('plugins.fzf'))
    table.insert(plugins, require('plugins.fzf-lua'))
    table.insert(plugins, require('plugins.nvim-tree'))
    table.insert(plugins, require('plugins.coc'))
end

return plugins
