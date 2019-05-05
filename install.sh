#! /bin/bash

cd ~

mkdir .conf_backup

for file in .aliases .bashrc .dircolors .gitconfig .profile .tmux.conf .vim/ .vimrc .zshrc; do
	cp $file .conf_backup/$file
	unlink $file
	rm -rf $file
	ln -s repos/configs/$file
done
