--[[
	I can move all the config file to 'nvim/plugin', but then my init.lua file
	would literally be completly empty. Also I don't have to worry about plugin
	load order, since I can control the layout however I want.

	Possible 'nvim/plugin' setup:
		- 'nvim/plugin/autocommands.lua': define my autocommands
		- 'nvim/plugin/keybindings.lua': define my keybinds
		- 'nvim/plugin/options.lua': set my neovim config
		- 'nvim/plugin/plugins.lua': load my plugins
--]]

-- LOGGER
--------------------------------------------------------------------------------

-- Initialize global logger for the files in 'lua/'
logger = require("vlog").new {
	plugin = vim.env.USER,

	-- Should print the output to neovim while running
	use_console = true,

	-- Should highlighting be used in console (using echohl)
	highlights = true,

	-- Should write to a file
	use_file = true,

	-- Any messages above this level will be logged.
	level = 'debug',

	-- Level configuration
	modes = {
		{ name = 'trace', hl = 'Comment', },
		{ name = 'debug', hl = 'Comment', },
		{ name = 'info',  hl = 'None', },
		{ name = 'warn',  hl = 'WarningMsg', },
		{ name = 'error', hl = 'ErrorMsg', },
		{ name = 'fatal', hl = 'ErrorMsg', },
	},

	-- Can limit the number of decimals displayed for floats
	float_precision = 0.01,
}

-- GENERAL SETTINGS
--------------------------------------------------------------------------------

-- Basic settings
	local opts = vim.opt

	-- Set vim's file encoding
	opts.encoding = 'utf-8'
	-- Ensure all text files opened in vim are treated as unix text files
	opts.fileformat = 'unix'
	opts.fileformats = 'unix'
	-- Disable the making of annoying swap files
	opts.swapfile = false

-- Search settings

	-- Highlight search matches
	opts.hlsearch = true
	-- Display the results that match the search pattern as you are typing it
	opts.incsearch = true
	-- Case insensitive searching
	opts.ignorecase = true
	-- Override ignorecase if search pattern has an uppercase character
	opts.smartcase = true

-- Tab/Indent settings

	-- Copy the indent of the current line when you start a new line
	opts.autoindent = true
	-- Preserves Indent when line wraps
	opts.breakindent = true
	-- Do not use spaces instead of tabs
	opts.expandtab = false
	-- Number of auto-indent spaces
	opts.shiftwidth = 4
	-- Number of spaces per Tab
	opts.tabstop = 4
	-- Enable unique indent options for C-style languages
	opts.smartindent = true
	-- Tabs use 'shiftwidth' at start of line and 'tabstop' elsewhere
	opts.smarttab = true

-- Quality of life Settings

	-- Enable mouse control
	opts.mouse = 'a'
	-- Display the outcome a command as you are typing it
	opts.inccommand = 'nosplit'
	-- Keep the cursor in the middle of the screen when scrolling
	opts.scrolloff = 999
	-- Use the system clipboard as the default register
	opts.clipboard = 'unnamedplus'
	-- Don't redraw the screen when preforming a macro
	opts.lazyredraw = true
	-- Complete longest common match, then each full match
	opts.wildmode = { 'longest', 'full', }
	-- Change the default way vim splits
	opts.splitbelow = true
	opts.splitright = true
	-- Change the delay vim take before updating buffer
	opts.updatetime = 100
	-- Don't adjust case of string to staisfy a match
	opts.infercase = true

-- Aesthetic Settings

	-- Enable 24-bit colour RGB
	opts.termguicolors = true
	-- Highlight the current line the cursor is on
	opts.cursorline = true
	-- Displays line numbers relative to the current line
	opts.relativenumber = true
	-- Display whitespace characters
	opts.list = true
	-- Define the minimum width of the line number column
	opts.numberwidth = 3
	-- Define the hight of the command mode line
	opts.cmdheight = 1
	-- Define the hight of the previously executed commands window
	opts.cmdwinheight = 10
	-- Change the way command completion suggestions are displayed
	opts.wildoptions = 'tagfile'
	-- Change the way lines that are too long is displayed
	opts.wrap = true
	opts.linebreak = true
	-- Change cursor shape for the different vim modes
	vim.o.guicursor = 'n-v-c-sm:bloc,i-ci-r-cr-o:hor20,i-ci:blinkon100-blinkoff100-blinkwait0'

-- Diff Settings

	-- Change specify that the histogram algorithm is used to generate diffs
	opts.diffopt = { 'internal', 'filler', 'closeoff', 'algorithm:histogram' }

-- KEYBINDINGS "
--------------------------------------------------------------------------------

	-- replace termcodes
	local t = require('keybindings.utils').t

-- Normal, Visual, and Operator-pending modes

	local keybind = vim.api.nvim_set_keymap
	-- Substitute all to 'S'
	keybind('', 'S', ':%s//g<Left><Left>', { noremap = true, })
	-- Have 'j', and 'k' move through visual lines instead of logical ones
	keybind('', 'j', 'gj', { noremap = true, })
	keybind('', 'k', 'gk', { noremap = true, })
	-- Have 'c', and 'C' not store the changed text in any register
	keybind('', 'c', '"_c', { noremap = true, })
	keybind('', 'C', '"_C', { noremap = true, })
	-- Have 'U' redo my last undo
	keybind('', 'U', t'<C-R>', { noremap = true, })
	-- Have 'q' replay previously activated macros
	keybind('', 'q', '@@', { noremap = true, })
	-- Have 'Q' replay previously activated macros
	keybind('', 'Q', 'q', { noremap = true, })
	-- Have 'zz' save and exit the buffer
	keybind('', 'zz', 'ZZ', { noremap = true, })
	-- Have 'zq' exit the buffer without saving
	keybind('', 'zq', 'ZQ', { noremap = true, })
	-- Have 'zb' delete the current buffer
	keybind('', 'zb', t':Bwipeout<CR>', { noremap = true, silent = true })
	-- Have 'zq' exit the buffer without saving
	keybind('', '<C-h>', '<C-w>h', { noremap = true, })
	keybind('', '<C-j>', '<C-w>j', { noremap = true, })
	keybind('', '<C-k>', '<C-w>k', { noremap = true, })
	keybind('', '<C-l>', '<C-w>l', { noremap = true, })
	-- Have 'Shift' + 'Deete' act as 'Delete'
	keybind('', t'<S-Del>', '<Del>', { noremap = true, })
	-- Have 'Ctrl' + 'f' call fuzzyfind
	keybind('', t'<C-f>', t':FZF<CR>', { noremap = true, })
	-- Have '<C-R>' Resize the window to the default
	keybind('', t'<C-r>', t'<C-w>=', {})
	-- Have 'Space' act as the leader key
	keybind('', t'<Space>', t'<leader>', { silent = true, })
	-- Have 'leader' + 'o' spell-check the current document
	keybind('', '<leader>o', t':setlocal spell! spelllang=en_us,en_gb<CR>', { silent = true, })
	-- Have 'leader' + 'g' toggle Goyo
	keybind('', t'<leader>g', t':ZenMode<CR>', { silent = true, })
	-- Have 'leader' + 'c' toggle the cursor column
	keybind('', t'<leader>c', t':setlocal cursorcolumn!<CR>', { silent = true, })
	-- Have 'leader' + 'wg' go to my general wiki
	keybind('', t'<leader>ww', t':VimwikiIndex<CR>', { silent = true, })

-- Insert, and Command-line modes

	-- Have 'Shift' + 'Delete' act as 'Delete'
	keybind('!', t'<S-Del>', t'<Del>', { noremap = true, })

-- Normal Mode Only

	-- Have 'x', and 'X' not store the deleted character in any register
	keybind('n', 'x', '"_x', { noremap = true })
	keybind('n', 'X', '"_X', { noremap = true })
	-- Have 'Space' + 'Space' unhighlight my last search
	keybind('n', t'<space><space>', t':noh<CR>', { noremap = true, silent = true })
	-- Have 'leader' + 'wh' convert only the current wiki
	keybind('n', t'<Leader>wh', t':Vimwiki2HTML<CR>', {})
	-- Have 'leader' + 'whh' convert all wikis to html
	keybind('n', t'<Leader>whh', t':VimwikiAll2HTML<CR>', {})

-- AUTOCOMMANDS
-------------------------------------------------------------------------------

	local make_autocmd = vim.api.nvim_create_autocmd

	-- Define autogroup for my autocommands
	local au_group_id = vim.api.nvim_create_augroup(vim.env.USER, {
	    clear = true
	})

	-- Delete all trailing whitespace and newlines at end of file on save
	make_autocmd('BufWritePre', {
		group = au_group_id,
		pattern = '*',
		command = [[%s/\s\+$//e | %s/\n\+\%$//e]],
	})

	-- Disable automatic commenting using 'o'
	make_autocmd('FileType', {
		group = au_group_id,
		pattern = '*',
		command = [[setlocal fo-=o]],
	})

	-- Update $HOME when a file in $DOTDIR is updated
	make_autocmd('BufWritePost', {
		group = au_group_id,
		pattern = vim.env.DOTDIR .. '/*',
		command = [[!dotpush]],
	})

	-- Reload wiki page in browser if any wiki data files are updated
	make_autocmd('BufWritePost', {
		group = au_group_id,
		pattern = vim.env.DOTDIR .. '/.local/share/wiki/*',
		command = [[!reloadwikibrowser]],
	})

	-- Refresh sxhdrc when my keybind file is updated
	make_autocmd('BufWritePost', {
		group = au_group_id,
		pattern = '*sxhkdrc',
		command = [[!pkill -USR1 sxhkd]],
	})

	-- Trigger autoread on cursor inactivity, buffer change, or terminal focus
	make_autocmd({ 'CursorHold', 'CursorHoldI', 'FocusGained', 'BufEnter' }, {
		group = au_group_id,
		pattern = '*',
		command = [[silent! checktime]],
	})

	-- Update plugins if plugin list is modified
	make_autocmd('BufWritePost', {
		group = au_group_id,
		pattern = vim.env.DOTDIR .. '/.config/nvim/lua/plugs/init.lua',
		command = [[source <afile> | PackerSync]],
	})

	-- Recompile packer if any plugin configs are modified
	make_autocmd('BufWritePost', {
		group = au_group_id,
		pattern = vim.env.DOTDIR .. '/.config/nvim/lua/{plugs/configs,keybindings}/*',
		callback = function(args)
			-- Reload my plugin list and their configs
			require('plenary.reload').reload_module('plugs', false)
			require('plenary.reload').reload_module('keybindings', false)
			require('plugs')

			vim.cmd([[echo ':PackerCompile' | PackerCompile]])
		end,
	})

-- PLUGINS
-------------------------------------------------------------------------------

-- Disable builtin plugins

	-- I don't use it
	vim.g.loaded_matchit = 1

	-- I find it annoying
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.loaded_netrwSettings = 1

-- Plugins and their configs are stored in 'lua/plugs'
require('plugs')
