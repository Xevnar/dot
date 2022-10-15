-- Setup completion engine
local capabilities = require('plugs.configs.autocmp').setup_for_source()

require('lspconfig').kotlin_language_server.setup {
	capabilites = capabilites,

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common()
	end,
}

-- Attach lsp to already open buffer
require('lspconfig').kotlin_language_server.manager.try_add_wrapper()
