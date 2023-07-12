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

for file in .aliases .bashrc .dircolors .gitconfig .gitmessage .profile .tmux .tmux.conf .vim .vimrc .zshrc .config/home-manager/home.nix; do
	if [ -f ~/"$file" ]; then
		if [[ -L ~/"$file" ]]; then
			unlink ~/$file
		else
			cp ~/$file ~/.conf_backup/`basename $file`
			rm -f ~/$file
		fi
	fi
	if [ -d ~/"$file" ]; then
		if [[ -L ~/"$file" ]]; then
			unlink ~/$file
		else
			cp -r ~/$file ~/.conf_backup/`basename $file`
			rm -rf ~/$file
		fi
	fi
	ln -sv $dotfile_dir/$file ~/$file
done

echo "dotfiles installed successfully"

# TMUX Config Install

set -e
set -u
set -o pipefail

is_app_installed() {
  type "$1" &>/dev/null
}

REPODIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "$REPODIR";

if ! is_app_installed tmux; then
  printf "WARNING: \"tmux\" command is not found. \
Install it first\n"
  exit 1
fi

if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  printf "WARNING: Cannot found TPM (Tmux Plugin Manager) \
 at default location: \$HOME/.tmux/plugins/tpm.\n"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install TPM plugins.
# TPM requires running tmux server, as soon as `tmux start-server` does not work
# create dump __noop session in detached mode, and kill it when plugins are installed
printf "Install TPM plugins\n"
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

printf "OK: Completed\n"
