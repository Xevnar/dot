-- Disable runtime ftplugin
vim.b.did_ftplugin = 1

-- Setup completion engine
require('plugs.configs.autocmp').setup_for_source()

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Launch language server
require('lspconfig').html.setup {
	cmd = { "vscode-html-languageserver", "--stdio" },
	filetypes = { "html", "xhtml", "php", },
	capabilities = capabilities,

	on_attach = function(client, bufnr)
		require('keybindings.lsp').common()
	end,
}

-- Call wrapper since lspstart occurs before sourcing ftplugin??
require('lspconfig').html.manager.try_add_wrapper()
