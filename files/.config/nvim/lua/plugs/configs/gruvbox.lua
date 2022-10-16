local M = {}

function M.setup()
	-- Must define the contrast level before loading the colorscheme
	vim.g.gruvbox_contrast_dark = 'hard'

	-- Set the colorscheme gruvbox dark
	vim.cmd([[colorscheme gruvbox]])
	vim.opt.background = 'dark'

	-- Fix operators not being highlighted when cursorline is on
	vim.cmd([[highlight! link Operator GruvboxFg1]])

	-- Change the highlighting of the diffs to make it clearer and easier on the eyes
	vim.cmd([[hi DiffAdd    gui=NONE                  guifg=NONE guibg=#0F3D07]])
	vim.cmd([[hi DiffChange gui=NONE                  guifg=NONE guibg=#32302F]])
	vim.cmd([[hi DiffDelete gui=bold                  guifg=NONE guibg=#490707]])
	vim.cmd([[hi DiffText   gui=bold,italic,underline guifg=NONE guibg=#004649]])
end

return M
