#!/bin/bash

set -e

if [ ! -d ~/repos/.ssh ]; then
	git clone git@github.com:LuckierDodge/.ssh.git ~/repos/.ssh
else
	cd ~/repos/.ssh && git pull
fi
if [ ! -d ~/.ssh ]; then
	mkdir -p ~/.ssh
fi
for file in authorized_keys config; do
	cp -f ~/repos/.ssh/$file ~/.ssh/$file
done

