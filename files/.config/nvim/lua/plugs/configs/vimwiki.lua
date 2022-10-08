local M = {}

function M.setup()
	-- General wiki
	local wiki_general = {
		name = 'Notes',
		syntax = 'markdown', ext = '.md',
		path = vim.env.XDG_DOCUMENTS_DIR .. '/wiki',
		path_html = vim.env.XDG_DOCUMENTS_DIR .. '/wiki_html',
		links_space_char = '_',
		custom_wiki2html = '',
		-- css files are stored in $XDG_DATA_HOME/vimwiki/css
		css_name = '',
	}

	-- Change extension-syntax association
	vim.g.vimwiki_ext2syntax = {
		['.Rmd'] = 'markdown',
		['.rmd'] = 'markdown',
		['.md'] = 'markdown',
		['.markdown'] = 'markdown',
		['.mdown'] = 'markdown',
	}

	-- Disable key mappings for html generation
	vim.g.vimwiki_key_mappings = { html = 0, }

	-- Wiki list
	vim.g.vimwiki_list = { wiki_general }
end

return M
