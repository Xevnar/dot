vim.cmd [[packadd packer.nvim]]

local configs = function(mod)
	return require('plugs.configs.' .. mod).setup
end

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Nice library
	use 'nvim-lua/plenary.nvim'

	-- Productivity
	use {
		'xevnar/vimwiki',
		branch = 'dev',
		requires = {
			{ "folke/zen-mode.nvim", config = configs('zen-mode') },
			'junegunn/limelight.vim',
		},
		config = configs('vimwiki'),
	}

	-- git Integration
	use {
		'tpope/vim-fugitive',
		{ 'airblade/vim-gitgutter', config = configs('gitgutter') },
	}

	-- Auto Completion
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
			'uga-rosa/cmp-dictionary',
			'kdheepak/cmp-latex-symbols',
			'onsails/lspkind-nvim',
		},
	}

	-- Language Server Configs
	use {
		'neovim/nvim-lspconfig',
		'mfussenegger/nvim-jdtls',
		'simrat39/rust-tools.nvim',
		{ 'Hoffs/omnisharp-extended-lsp.nvim', requires =  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', } },
	}

	-- Debugging
	use {
		'mfussenegger/nvim-dap',
		requires = {
			'rcarriga/nvim-dap-ui',
			'leoluz/nvim-dap-go',
		}
	}

	-- Snippits
	use {
		'hrsh7th/vim-vsnip',
		requires = 'hrsh7th/vim-vsnip-integ',
		config = configs('vsnip'),
	}

	-- Syntax highlighting
	use {
		'baskerville/vim-sxhkdrc',
		'harenome/vim-mipssyntax',
		{
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			requires = 'nvim-treesitter/playground',
			config = configs('treesitter')
		},
	}

	-- QoL improvements
	use {
		'moll/vim-bbye', -- Delete buffers without closing windows
		'danro/rename.vim',
		'tpope/vim-surround',
		'tpope/vim-commentary',
		{ 'jiangmiao/auto-pairs', config = configs('autopairs') },
		{ 'RRethy/vim-hexokinase', run = 'make hexokinase', config = configs('hexokinase') },
	}

	-- Themes
	use {
		{ 'arcticicestudio/nord-vim', config = configs('nord'), disable = true, },
		{ 'morhetz/gruvbox', config = configs('gruvbox'), },
	}
end)
