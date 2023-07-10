#! /bin/bash

set -e

dotfile_dir=~/repos/configs
echo "Dotfiles path: $dotfile_dir"

if [ ! -d ~/.conf_backup ]; then
	echo "Preparing dotfiles backup"
	mkdir -p ~/.conf_backup
else
	echo "Removing old dotfiles backup"
	rm -rf ~/.conf_backup
	mkdir -p ~/.conf_backup
fi

for file in .aliases .bashrc .dircolors .gitconfig .gitmessage .profile .tmux.conf .vim .vimrc .zshrc .config/home-manager/home.nix; do
	if [ -f ~/"$file" ]; then
		if [[ -L ~/"$file" ]]; then
			unlink ~/$file
		else
			cp ~/$file ~/.conf_backup/$file
			rm -f ~/$file
		fi
	fi
	if [ -d ~/"$file" ]; then
		if [[ -L ~/"$file" ]]; then
			unlink ~/$file
		else
			cp -r ~/$file ~/.conf_backup/$file
			rm -rf ~/$file
		fi
	fi
	ln -sv $dotfile_dir/$file ~/$file
done

echo "dotfiles installed successfully"
