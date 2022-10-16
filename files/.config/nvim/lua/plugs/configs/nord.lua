local M = {}

function M.setup()
	-- Set the colorscheme nord dark
	vim.cmd([[colorscheme nord]])
	vim.opt.background = 'dark'

	-- Use a more contrasting color for the cursor lines
	vim.cmd([[highlight CursorLine   guibg=#121F30]])
	vim.cmd([[highlight CursorColumn guibg=#121F30]])

	-- Change the highlighting of the diffs to make it clearer and easier on the eyes
	vim.cmd([[hi DiffAdd    gui=NONE                  guifg=NONE guibg=#0F3D07]])
	vim.cmd([[hi DiffChange gui=NONE                  guifg=NONE guibg=#32302F]])
	vim.cmd([[hi DiffDelete gui=bold                  guifg=NONE guibg=#490707]])
	vim.cmd([[hi DiffText   gui=bold,italic,underline guifg=NONE guibg=#004649]])
end

return M
