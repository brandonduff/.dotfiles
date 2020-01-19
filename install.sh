#!/bin/bash

ln -sf ~/.dotfiles/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/.aliases ~/.aliases
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/init.el ~/.emacs.d/init.e
if [ ! -z "$NO_TMUXINATOR" ]
then
	ln -sf ~/.dotfiles/.bashrc ~/.bashrc
	gem install tmuxinator
fi
