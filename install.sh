#! /bin/bash

set -e

cd ~
rm -rf .bashrc .dircolors .gitconfig .profile .tmux.conf .vim/ .vimrc

for file in .bashrc .dircolors .gitconfig .profile .tmux.conf .vim/ .vimrc; do
	ln -s repos/configs/$file
done

. .bashrc
