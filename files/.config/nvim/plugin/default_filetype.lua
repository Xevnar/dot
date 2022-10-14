-- Set the default filetype for all unknown files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, {
	group = 'xev',
	pattern = '*',
	command = [[if &ft == '' | set ft=txt | endif]],
})
