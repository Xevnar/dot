local M = {}

function M.setup()
	-- Define the wiki root
	vim.g.wiki_root = vim.env.XDG_DOCUMENTS_DIR .. '/wiki'

	-- Set wiki to work with markdown
	vim.g.wiki_filetypes = { 'md' }
	vim.g.wiki_link_extension = '.md'

	-- Set wiki link types to markdown
	vim.g.wiki_link_target_type = 'md'

	-- Set journal
	vim.g.wiki_journal = {
		name = 'journal',
		frequency = 'weekly',
		date_format = {
			weekly = '%Y/week_%U',
		}
	}

	-- Set keybindings
	local opts = require('keybindings.utils').opts

	vim.keymap.set('', '<leader>wj', '<plug>(wiki-journal)', opts.noremap)
end

return M
