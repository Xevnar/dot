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
	local opt = vim.opt

	-- Set vim's file encoding
	opt.encoding = 'utf-8'
	-- Ensure all text files opened in vim are treated as unix text files
	opt.fileformat = 'unix'
	opt.fileformats = 'unix'
	-- Disable the making of annoying swap files
	opt.swapfile = false

-- Search settings

	-- Highlight search matches
	opt.hlsearch = true
	-- Display the results that match the search pattern as you are typing it
	opt.incsearch = true
	-- Case insensitive searching
	opt.ignorecase = true
	-- Override ignorecase if search pattern has an uppercase character
	opt.smartcase = true

-- Tab/Indent settings

	-- Copy the indent of the current line when you start a new line
	opt.autoindent = true
	-- Preserves Indent when line wraps
	opt.breakindent = true
	-- Do not use spaces instead of tabs
	opt.expandtab = false
	-- Number of auto-indent spaces
	opt.shiftwidth = 4
	-- Number of spaces per Tab
	opt.tabstop = 4
	-- Enable unique indent options for C-style languages
	opt.smartindent = true
	-- Tabs use 'shiftwidth' at start of line and 'tabstop' elsewhere
	opt.smarttab = true

-- Quality of life Settings

	-- Enable mouse control
	opt.mouse = 'a'
	-- Display the outcome a command as you are typing it
	opt.inccommand = 'nosplit'
	-- Keep the cursor in the middle of the screen when scrolling
	opt.scrolloff = 999
	-- Use the system clipboard as the default register
	opt.clipboard = 'unnamedplus'
	-- Don't redraw the screen when preforming a macro
	opt.lazyredraw = true
	-- Complete longest common match, then each full match
	opt.wildmode = { 'longest', 'full', }
	-- Change the default way vim splits
	opt.splitbelow = true
	opt.splitright = true
	-- Change the delay vim take before updating buffer
	opt.updatetime = 100
	-- Don't adjust case of string to staisfy a match
	opt.infercase = true

-- Aesthetic Settings

	-- Enable 24-bit colour RGB
	opt.termguicolors = true
	-- Highlight the current line the cursor is on
	opt.cursorline = true
	-- Displays line numbers relative to the current line
	opt.relativenumber = true
	-- Display whitespace characters
	opt.list = true
	-- Define the minimum width of the line number column
	opt.numberwidth = 3
	-- Define the hight of the command mode line
	opt.cmdheight = 1
	-- Define the hight of the previously executed commands window
	opt.cmdwinheight = 10
	-- Change the way command completion suggestions are displayed
	opt.wildoptions = 'tagfile'
	-- Change the maximum width of text
	opt.textwidth = 120
	-- Change the way lines that are too long is displayed
	opt.wrap = true
	opt.linebreak = true
	-- Change cursor shape for the different vim modes
	vim.o.guicursor = 'n-v-c-sm:bloc,i-ci-r-cr-o:hor20,i-ci:blinkon100-blinkoff100-blinkwait0'

-- Diff Settings

	-- Change specify that the histogram algorithm is used to generate diffs
	opt.diffopt = { 'internal', 'filler', 'closeoff', 'algorithm:histogram' }

-- KEYBINDINGS "
--------------------------------------------------------------------------------

	-- replace termcodes
	local t = require('keybindings.utils').t

	local opts = require('keybindings.utils').opts

-- Normal, Visual, and Operator-pending modes

	local keybind = vim.keymap.set
	-- Substitute all to 'S'
	keybind('', 'S', ':%s//g<Left><Left>', opts.noremap)
	-- Have 'j', and 'k' move through visual lines instead of logical ones
	keybind('', 'j', 'gj', opts.noremap)
	keybind('', 'k', 'gk', opts.noremap)
	-- Have 'c', and 'C' not store the changed text in any register
	keybind('', 'c', '"_c', opts.noremap)
	keybind('', 'C', '"_C', opts.noremap)
	-- Have 'U' redo my last undo
	keybind('', 'U', t'<C-R>', opts.noremap)
	-- Have 'q' replay previously activated macros
	keybind('', 'q', '@@', opts.noremap)
	-- Have 'Q' replay previously activated macros
	keybind('', 'Q', 'q', opts.noremap)
	-- Have 'zz' save and exit the buffer
	keybind('', 'zz', 'ZZ', opts.noremap)
	-- Have 'zq' exit the buffer without saving
	keybind('', 'zq', 'ZQ', opts.noremap)
	-- Have 'zb' delete the current buffer
	keybind('', 'zb', t':Bwipeout<CR>', opts.both)
	-- Have 'zq' exit the buffer without saving
	keybind('', '<C-h>', '<C-w>h', opts.noremap)
	keybind('', '<C-j>', '<C-w>j', opts.noremap)
	keybind('', '<C-k>', '<C-w>k', opts.noremap)
	keybind('', '<C-l>', '<C-w>l', opts.noremap)
	-- Have 'Shift' + 'Delete' act as 'Delete'
	keybind('', t'<S-Del>', '<Del>', opts.noremap)
	-- Have '<C-R>' Resize the window to the default
	keybind('', t'<C-r>', t'<C-w>=', opts.remap)
	-- Have 'Space' act as the leader key
	keybind('', t'<Space>', t'<leader>', opts.silent)
	-- Have 'leader' + 'o' spell-check the current document
	keybind('', '<leader>o', t':setlocal spell! spelllang=en_us,en_gb<CR>', opts.silent)
	-- Have 'leader' + 'c' toggle the cursor column
	keybind('', t'<leader>c', t':setlocal cursorcolumn!<CR>', opts.silent)

-- Insert, and Command-line modes

	-- Have 'Shift' + 'Delete' act as 'Delete'
	keybind('!', t'<S-Del>', t'<Del>', opts.noremap)

-- Normal Mode Only

	-- Have 'x', and 'X' not store the deleted character in any register
	keybind('n', 'x', '"_x', opts.noremap)
	keybind('n', 'X', '"_X', opts.noremap)
	-- Have 'Space' + 'Space' unhighlight my last search
	keybind('n', t'<space><space>', t':noh<CR>', opts.both)

	-- Diagnostic keymappings
	keybind('n', t'<leader>e', vim.diagnostic.open_float, opts.both)
	keybind('n', '[d', vim.diagnostic.goto_prev, opts.both)
	keybind('n', ']d', vim.diagnostic.goto_next, opts.both)
	keybind('n', t'<leader>q', vim.diagnostic.setloclist, opts.both)

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

	-- I don't want to use the fzf plugin shipped in pacman
	vim.g.loaded_fzf = 1

-- Plugins and their configs are stored in 'lua/plugs'
require('plugs')
