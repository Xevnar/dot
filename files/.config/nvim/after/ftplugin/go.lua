-- Setup completion engine
local capabilities = require('plugs.configs.autocmp').setup_for_source()

-- Launch language server
require('lspconfig').gopls.setup {
	capabilities = capabilities,

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common()
	end,
}

-- Call wrapper since lspstart occurs before sourcing ftplugin??
require('lspconfig').gopls.manager.try_add_wrapper()
