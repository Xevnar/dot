-- Launch lanquage server
require('lspconfig').ccls.setup {
	-- Setup completion engine
	capabilities = require('plugs.configs.autocmp').setup_for_source(),

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common(bufnr)
	end,
}

-- Call wrapper since lspstart occurs before sourcing ftplugin??
require('lspconfig').ccls.manager.try_add_wrapper()
