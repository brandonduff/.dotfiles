syntax enable
filetype plugin indent on
" Search down into subfolders when doing file finds
set path+=**
set wildmenu

let mapleader = ","

set number
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
call plug#end()

" Save on leaving insert
autocmd InsertLeave * write

nnoremap <Leader>t :Sexe mix test<CR>

" Copy file path to clipboard
nnoremap <Leader>cp :let @+ = expand('%')<CR>

" Ruby bindings

" Run RSpec on current dir
nnoremap <Leader>rr :!rspec .<CR>

" Run RSpec on current file
nnoremap <Leader>rf :!rspec %<CR>
nnoremap <Leader>d :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
