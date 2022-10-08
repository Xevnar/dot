-- Disable runtime ftplugin
vim.b.did_ftplugin = 1

-- Setup completion engine
local capabilities = require('plugs.configs.autocmp').setup_for_source()

-- Launch lanquage server
require('lspconfig').ccls.setup {
	capabilities = capabilities,

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common()
	end,
}

-- Call wrapper since lspstart occurs before sourcing ftplugin??
require('lspconfig').ccls.manager.try_add_wrapper()
