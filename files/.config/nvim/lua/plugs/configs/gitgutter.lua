local M = {}

function M.setup()
	-- Disable GitGutter keymappings
	vim.g.gitgutter_map_keys = 0

	-- Change GitGutter Symbols
	vim.g.gitgutter_sign_added = '++'
	vim.g.gitgutter_sign_modified = '~~'
	vim.g.gitgutter_sign_removed = '--'
	vim.g.gitgutter_sign_removed_first_line = '^^'
	vim.g.gitgutter_sign_removed_above_and_below = '{}'
	vim.g.gitgutter_sign_modified_removed = '~-'

	-- Change sign column color to match the line number column
	vim.cmd([[highlight! link SignColumn LineNr]])
end

return M
