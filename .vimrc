syntax enable
filetype plugin indent on
set sw=4
set ts=4
autocmd Filetype ruby set softtabstop=2
autocmd Filetype ruby set sw=2
autocmd Filetype ruby set ts=2

set noswapfile
set nobackup

if !isdirectory("/tmp/.vim-undo-dir")
    call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif
set undodir=/tmp/.vim-undo-dir
set undofile

autocmd Filetype markdown set spell
" Search down into subfolders when doing file finds
set path+=**
set wildmenu

let mapleader = ","

set number
set relativenumber
set backspace=indent,eol,start
set hlsearch

nnoremap <Leader>w :w<Return>
nnoremap <Leader>s :so ~/.vimrc<Return>
nnoremap <Leader>e :e ~/.vimrc<Return>
nnoremap <Leader>q :wq<Return>
nnoremap <Leader><CR> :noh<CR>
inoremap fd <Esc>
inoremap <C-]> <Esc>O
nnoremap <Leader>cd :cd %:h<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'gu-fan/simpleterm.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'masukomi/vim-markdown-folding'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim'
call plug#end()

" Save on leaving insert
autocmd InsertLeave * write

" Copy file path to clipboard
nnoremap <Leader>cp :let @+ = expand('%')<CR>

" Copy file path to clipboard
nnoremap <Leader>cl :let @+ = expand('%') . ':' . line('.')<CR>

" Ruby bindings

let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" Run RSpec on nearest test
nnoremap <Leader>t :call RunNearestSpec()<CR>

" Run RSpec on current file
nnoremap <Leader>rf :call RunCurrentSpecFile()<CR>

let g:netrw_banner=0

noremap <C-p> :FZF<CR>
