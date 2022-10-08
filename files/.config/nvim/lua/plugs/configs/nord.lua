local M = {}

function M.setup()
	-- Set the colorscheme nord dark
	vim.cmd([[colorscheme nord]])
	vim.opt.background = 'dark'

	-- Use a more contrasting color for the cursor lines
	vim.cmd([[highlight CursorLine   guibg=#121F30]])
	vim.cmd([[highlight CursorColumn guibg=#121F30]])
end

return M
