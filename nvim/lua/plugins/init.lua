local plugins = {
	require('plugins.code'),
}

if not vim.g.vscode then
	table.insert(plugins, require('plugins.ui'))
	table.insert(plugins, require('plugins.move'))
	table.insert(plugins, require('plugins.lsp'))
	-- table.insert(plugins, require('plugins.dap'))
end

return plugins
