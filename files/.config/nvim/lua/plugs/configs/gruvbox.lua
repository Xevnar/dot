local M = {}

function M.setup()
	-- Must define the contrast level before loading the colorscheme
	vim.g.gruvbox_contrast_dark = 'hard'

	-- Set the colorscheme gruvbox dark
	vim.cmd([[colorscheme gruvbox]])
	vim.opt.background = 'dark'

	-- Fix operators not being highlighted when cursorline is on
	vim.cmd([[highlight! link Operator GruvboxFg1]])
end

return M
