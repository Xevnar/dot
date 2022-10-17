-- Launch language server
require('lspconfig').gopls.setup {
	-- Setup completion engine
	capabilities = require('plugs.configs.autocmp').setup_for_source(),

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common(bufnr)
	end,
}

-- Call wrapper since lspstart occurs before sourcing ftplugin??
require('lspconfig').gopls.manager.try_add_wrapper()
