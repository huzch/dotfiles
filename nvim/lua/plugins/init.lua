local plugins = {
    require('plugins.nvim-surround'),
    require('plugins.nvim-treesitter'),
	--require('plugins.copilot')
}

if not vim.g.vscode then
    table.insert(plugins, require('plugins.onedark'))
    table.insert(plugins, require('plugins.lightline'))
    table.insert(plugins, require('plugins.tmuxline'))
    table.insert(plugins, require('plugins.cpp-enhanced-highlight'))
    table.insert(plugins, require('plugins.nvim-autopairs'))
    table.insert(plugins, require('plugins.Comment'))
    table.insert(plugins, require('plugins.fzf'))
    table.insert(plugins, require('plugins.fzf-lua'))
    table.insert(plugins, require('plugins.nvim-tree'))
    table.insert(plugins, require('plugins.coc'))
end

return plugins
