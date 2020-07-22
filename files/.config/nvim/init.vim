" PLUGINS "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check if vim-plug is installed, and install it if it is not
  if ! filereadable(system('echo -n "$HOME/.config/nvim/autoload/plug.vim"'))

    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p $HOME/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall

  endif

" Plugin list
  call plug#begin('$HOME/.config/nvim/plugins')

    " Productivity
      Plug 'vimwiki/vimwiki'
      Plug 'junegunn/goyo.vim'
      Plug 'junegunn/limelight.vim'
    " Quality of life improvements
      Plug 'tpope/vim-surround'
      Plug 'tpope/vim-commentary'
      Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
    " Syntax highlighting
      Plug 'baskerville/vim-sxhkdrc'
    " Theme
      Plug 'arcticicestudio/nord-vim'

  call plug#end()

" GENERAL SETTINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings

  " Enable filetype detection and filetype specific plugins
    filetype plugin on
  " Enable syntax highlighting
    syntax on
  " Set vim's file encoding
    set encoding=utf-8
  " Disable the making of annoying swap files
    set noswapfile

" Search settings

  " Highlight search matches
    set hlsearch
  " Display the results that match the search pattern as you are typing it
    set incsearch
  " Case insensitive searching
    set ignorecase
  " Override ignorecase if search pattern has an uppercase character
    set smartcase

" Tab/Indent settings

  " Copy the indent of the current line when you start a new line
    set autoindent
  " Preserves Indent when line wraps
    set breakindent
  " Use spaces instead of tabs
    set expandtab
  " Number of auto-indent spaces
    set shiftwidth=2
  " Number of spaces per Tab
    set tabstop=2
  " Enable unique indent options for C-style languages
    set smartindent
  " Tabs use 'shiftwidth' at start of line and 'tabstop' elsewhere
    set smarttab

" Quality of life Settings

  " Enable mouse control
    set mouse=a
  " Display the outcome a command as you are typing it
    set inccommand=nosplit
  " Keep the cursor in the middle of the screen when scrolling
    set scrolloff=999
  " Use the system clipboard as the default register
    set clipboard=unnamedplus
  " Don't redraw the screen when preforming a macro
    set lazyredraw
  " Complete longest common match, then each full match
    set wildmode=longest,full
  " Change the default way vim splits
    set splitbelow splitright

" Aesthetic Settings

  " Set vim's coloursheme
    colorscheme nord
    set background=dark
  " Enable 24-bit colour RGB
    set termguicolors
  " Highlight the current line the cursor is on
    set cursorline
  " Displays line numbers relative to the current line
    set relativenumber
  " Define the minimum width of the line number column
    set numberwidth=3
  " Define the hight of the command mode line
    set cmdheight=1
  " Define the hight of the previously executed commands window
    set cmdwinheight=10
  " Change the way command completion suggestions are displayed
    set wildoptions=tagfile
  " Change the way lines that are too long is displayed
    set wrap
    set linebreak
  " Change the colour of the current line and column highlights
    highlight CursorLine guibg=#121F30
    highlight CursorColumn guibg=#121F30


" KEYBINDINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set custom leader character
  let mapleader =";"

" Normal, Visual, and Operator-pending modes

  " switch the functions of 's' and 'l'
    noremap l s
    noremap s l
  " Substitute all to 'L'
    noremap L :%s//g<Left><Left>
  " Make 'H', and 'S' act like extreme versions of 's', and 'h'
    noremap S $
    noremap H 0
  " Have 'j', and 'k' move through visual lines instead of logical ones
    noremap j gj
    noremap k gk
  " Have 'J', and 'K' scroll down, and up half a page respectively
    noremap J <C-D>
    noremap K <C-U>
  " Have 'c', and 'C' not store the changed text in any register
    noremap c "_c
    noremap C "_C
  " Have 'U' redo my last undo
    noremap U <C-R>
  " Have 'q' replay previously activated macros
    noremap q @@
  " Have 'Q' replay previously activated macros
    noremap Q q
  " Have 'zz' save and exit the buffer
    noremap zz ZZ
  " Have 'zq' exit the buffer without saving
    noremap zq ZQ
  " Have 'Shift' + 'Delete' act as 'Delete'
    noremap <S-Del> <Del>
  " Have 'Backspace' delete characters behind the cursor
    noremap <BS> X
  " Have ';' + 'o' spell-check the current document
    map <leader>o :setlocal spell! spelllang=en_us,en_gb<CR>
  " Have ';' + 'g' toggle Goyo
    map <leader>g :Goyo<CR>
  " Have ';' + 'c' toggle the cursor column
    map <leader>c :setlocal cursorcolumn!<CR>

" Insert, and Command-line modes

  " Have 'Shift' + 'Delete' act as 'Delete'
    noremap! <S-Del> <Del>

" Normal Mode Only

  " Have 'x', and 'X' not store the deleted character in any register
    nnoremap x "_x
    nnoremap X "_X
  " Have 'o' and 'O' add a new line only
    nnoremap o o<ESC>
    nnoremap O O<ESC>
  " Have 'Space' unhighlight my last search
    nnoremap <silent> <space> :noh<CR>


" AUTO-COMMANDS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete all trailing whitespace and newlines at end of file on save
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritepre * %s/\n\+\%$//e

" Disable automatic commenting on a newline
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Refresh sxhdrc when my keybind file is updated
  autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" PLUGIN SETTINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hexokinase

  " Colour display method
    let g:Hexokinase_highlighters = ['virtual']

" Goyo

  " Change settings when entering goyo
    function! s:goyo_enter()
      set noshowmode
      set noshowcmd
      Limelight
    endfunction

  " Restore changed settings when exiting goyo
    function! s:goyo_leave()
      set showmode
      set showcmd
      Limelight!
      highlight CursorLine guibg=#121F30
      highlight CursorColumn guibg=#121F30
    endfunction

  " Call the previous functions when entering or exiting goyo
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()

" VimWiki

  " General wiki
    let wiki_1 = {}
    let wiki_1.path = '~/documents/wiki/'

  " Wiki list
    let g:vimwiki_list = [wiki_1]
