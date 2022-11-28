local M = {}

function M.setup()
	local telescope = require('telescope')
	local telescopeConfig = require('telescope.config')

	-- Modify the default telescope configuration to show hidden files excluding git dir
	local vimgrep_args = {
		'rg',
		'--color=never',
		'--no-heading',
		'--with-filename',
		'--line-number',
		'--column',
		'--smart-case',
		'--hidden',
		'--glob',
		'!**/.git/*',
	}

	-- Set all available find commands to exclude git dirs
	local find_command
	if 1 == vim.fn.executable 'rg' then
		find_command = { 'rg', '--files', '--color=never', '--hidden', '--glob', '!**/.git/*' }
	elseif 1 == vim.fn.executable 'fd' then
		find_command = { 'fd', '--type', 'f', '--color=never', '--hidden', '--exclude', '**/.git/*' }
	elseif 1 == vim.fn.executable 'find' and vim.fn.has 'win32' == 0 then
		find_command = { 'find', '.', '-type', 'd', '-name', '.git', '-prune', '-o', '-type', 'f', '-print' }
	elseif 1 == vim.fn.executable 'where' then
		find_command = { 'where', '/r', '.', '*' }
	end

	telescope.setup({
		defaults = {
			vimgrep_arguments = vimgrep_args,
		},
		pickers = {
			find_files = {
				find_command = find_command,
			},
		},
	})

	-- Set keybindings
	local opts = require('keybindings.utils').opts

	-- Have 'Ctrl' + 'ff' call fuzzyfind for files
	vim.keymap.set('', '<C-f>f', ':Telescope find_files<CR>', opts.noremap)
	vim.keymap.set('', '<C-f><C-f>', ':Telescope find_files<CR>', opts.noremap)
end

return M
