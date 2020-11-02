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
      Plug 'airblade/vim-gitgutter'
      Plug 'tpope/vim-surround'
      Plug 'tpope/vim-commentary'
      Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
    " Syntax highlighting
      Plug 'baskerville/vim-sxhkdrc'
    " Theme
      Plug 'arcticicestudio/nord-vim'
      Plug 'morhetz/gruvbox'

  call plug#end()

" PLUGIN SETTINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nord

"  " Set vim's coloursheme
"    colorscheme nord
"    set background=dark
"  " Change the colour of the current line and column highlights
"    highlight CursorLine guibg=#121F30
"    highlight CursorColumn guibg=#121F30

" Gruvbox

  " Set vim's coloursheme
    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox
    set background=dark

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
    endfunction

  " Call the previous functions when entering or exiting goyo
    autocmd! User GoyoEnter nested call <SID>goyo_enter()
    autocmd! User GoyoLeave nested call <SID>goyo_leave()

" GitGutter

  " Disable GitGutter keymappings
    let g:gitgutter_map_keys = 0

  " Change GitGutter Symbols
    let g:gitgutter_sign_added = '++'
    let g:gitgutter_sign_modified = '~~'
    let g:gitgutter_sign_removed = '--'
    let g:gitgutter_sign_removed_first_line = '^^'
    let g:gitgutter_sign_removed_above_and_below = '{}'
    let g:gitgutter_sign_modified_removed = '~-'
  " Change sign column color
    highlight! link SignColumn LineNr

" VimWiki

  " General wiki
    let wiki_1 = {}
    let wiki_1.path = '~/documents/wiki/'

  " Wiki list
    let g:vimwiki_list = [wiki_1]

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
  " Change the delay vim take before updating buffer
    set updatetime=100

" Aesthetic Settings

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


" KEYBINDINGS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set custom leader character
  let mapleader =<space>

" Normal, Visual, and Operator-pending modes

  " Switch the functions of 's' and 'l'
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
  " Have 'zq' exit the buffer without saving
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-s> <C-w>l
    " Have 'Shift' + 'Delete' act as 'Delete'
    noremap <S-Del> <Del>
  " Have 'leader' + 'o' spell-check the current document
    map <silent> <leader>o :setlocal spell! spelllang=en_us,en_gb<CR>
  " Have 'leader' + 'g' toggle Goyo
    map <silent> <leader>g :Goyo<CR>
  " Have 'leader' + 'c' toggle the cursor column
    map <silent> <leader>c :setlocal cursorcolumn!<CR>

" Insert, and Command-line modes

  " Have 'Shift' + 'Delete' act as 'Delete'
    noremap! <S-Del> <Del>

" Normal Mode Only

  " Have 'x', and 'X' not store the deleted character in any register
    nnoremap x "_x
    nnoremap X "_X
  " Have 'Space' + 'Space' unhighlight my last search
    nnoremap <silent> <space><space> :noh<CR>


" AUTO-COMMANDS "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete all trailing whitespace and newlines at end of file on save
  autocmd BufWritePre * %s/\s\+$//e
  autocmd BufWritepre * %s/\n\+\%$//e

" Disable automatic commenting using 'o'
  autocmd FileType * setlocal fo-=o

" Refresh sxhdrc when my keybind file is updated
  autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Trigger autoread on cursor inactivity, buffer change, or terminal focus
  autocmd CursorHold,CursorHoldI,FocusGained,BufEnter * checktime

" Highlight the specific words so that they stick out more
  augroup vimrc_todo
      au!
      au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|BUG|OPTIMIZE|XXX)/
            \ containedin=.*Comment,vimCommentTitle
  augroup END
  hi def link MyTodo Todo
