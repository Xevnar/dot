-- Launch language server
require('lspconfig').html.setup {
	cmd = { "vscode-html-languageserver", "--stdio" },
	filetypes = { "html", "xhtml", "php", },

	-- Setup completion engine
	capabilities = require('plugs.configs.autocmp').setup_for_source(),

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common(bufnr)
	end,
}

-- Call wrapper since lspstart occurs before sourcing ftplugin??
require('lspconfig').html.manager.try_add_wrapper()
