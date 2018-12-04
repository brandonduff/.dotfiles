syntax enable

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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-endwise'
call plug#end()
