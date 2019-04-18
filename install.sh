#! /bin/bash

set -e

cd ~
rm -rf  .bashrc .dircolors .gitconfig .profile .tmux.conf .vim .vimrc .zshrc

for file in .aliases .bashrc .dircolors .gitconfig .profile .tmux.conf .vim/ .vimrc .zshrc; do
	ln -s repos/configs/$file
done

. .bashrc
