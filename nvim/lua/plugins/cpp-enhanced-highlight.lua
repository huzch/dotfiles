return {
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
}
