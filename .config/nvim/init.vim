call plug#begin('~/.config/nvim/plugins')
	Plug 'arcticicestudio/nord-vim'
        Plug 'baskerville/vim-sxhkdrc'
        Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/limelight.vim'
        Plug 'psliwka/vim-smoothie'
call plug#end()

filetype plugin indent on
syntax on           "Enables syntax highlighting
set incsearch  	    "Displys patterns that match the search as you are typing
set hlsearch        "Highlights search matches
set autoindent      "Indents a line when you hit enter
set relativenumber  "Displays line numbers relative to the current line
set history=100     "How many commands and search patterns are kept in my history
set showcmd         "Shows incomplete command in the lower right corner
set ruler           "Shows current cursor position in the lower right corner
set ignorecase      "Ignores case when searching
set smartcase       "Overrides ignore case if pattern has an upper case character
set scrolloff=99    "Keeps the cursor 22 lines away from the edges the screen when scrolling
set wrap            "Wraps text that exeeds window size
set linebreak
"set breakindent     "Preserves Indent when line wraps
set shiftwidth=2
set expandtab
set softtabstop=2
set clipboard=unnamedplus
set lazyredraw

colorscheme nord
set background=dark


" KEYBINDINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Normal, Visual, and Operator-pending modes

  " Make 'l', and 'L' the substitute commands
    noremap l s
    noremap L S
  " Make 's' take the role of 'l'
    noremap s l
  " Make 'H', and 'S' act like extreme versions of 's', and 'h'
    noremap S $
    noremap H 0
  " Have 'j', and 'k' move through visual lines insteag of logical ones
    noremap j gj
    noremap k gk
  " Have 'J', and 'K' scroll down, and up half a page respectivly
    noremap J <C-D>
    noremap K <C-U>
  " Have 'c', and 'C' not store the changed text in any register
    noremap c "_c
    noremap C "_c
  " Have 'U' redo my last undo
    noremap U <C-R>
  " Have 'Shift + Delete' act as 'Delete'
    noremap <S-Del> <Del>

" Insert, and Command-line modes

  " Have 'Shift + Delete' act as 'Delete'
    noremap! <S-Del> <Del>

" Normal Mode Only

  " Have 'x', and 'X' not store the deleted character in any register
    nnoremap x "_x
    nnoremap X "_X
  " Have 'Escape' unhighlight my last search
    nnoremap <ESC> :noh<ESC>

" AUTO-COMMANDS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete all trailing whitespace and newlines at end of file on save
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritepre * %s/\n\+\%$//e

" Disable automatic commenting on newline
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" PLUGIN SETTINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:Hexokinase_highlighters = ['virtual']
set termguicolors
