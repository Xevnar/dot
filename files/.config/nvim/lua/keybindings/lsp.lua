local utils = require('keybindings.utils')

local M = {}

local opts = utils.opts

function M.common(bufnr)
	-- Set Omnifunc
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local bufopts = vim.tbl_extend('force', opts.both, { buffer = bufnr, })

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts) -- Displays help ctxt-menu
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

function M.jdtls(bufnr)
	M.common(bufnr)

	-- Java specific
	local bufopts = vim.tbl_extend('force', opts.both, { buffer = bufnr, })

	vim.keymap.set('n', '<leader>di', require('jdtls').organize_imports(), bufopts)
	vim.keymap.set('n', '<leader>dt', require('jdtls').test_class(), bufopts)
	vim.keymap.set('n', '<leader>dn', require('jdtls').test_nearest_method(), bufopts)
	vim.keymap.set('n', '<leader>de', require('jdtls').extract_variable(), bufopts)
end

return M
