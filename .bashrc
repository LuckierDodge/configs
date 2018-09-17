# .bashrc

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# History options
shopt -s histappend
export HISTIGNORE="exit:ls:ll:la:c:clear:cd"
HISTTIMEFORMAT='%F %T '
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# Check window size after each command
shopt -s checkwinsize 

Red='\[\e[01;31m\]'
Green='\[\e[01;32m\]'
Yellow='\[\e[01;33m\]'
Blue='\[\e[01;34m\]'
Cyan='\[\e[01;36m\]'
White='\[\e[01;37m\]'
Orange='\[\e[00;33m\]'
Purple='\[\e[00;35m\]'
Reset='\[\e[00m\]'
DarkGreen='\[\e[00;32m\]'

# Set prompt
git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_clean()
{
	if [[ $(git status 2> /dev/null | tail -1) != "nothing to commit, working directory clean" ]]; then
		echo "$Yellow$(git_branch)"
	else
		echo "$Green$(git_branch)"
	fi
}

set_prompt ()
{
	PS1="$Blue($Green\u$Blue) $DarkGreen\h $Purple[$Cyan\w$Purple]"
	if [ -n "$(git_branch)" ]; then
		PS1+=" $(git_clean)"
	fi
	PS1+=" $White-> $Reset"
}

PROMPT_COMMAND='set_prompt'

# If this is an xterm set title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# Alias definitions
# ssh aliases
alias tiger='ssh z1764034@tiger.cs.niu.edu'
alias hopper='ssh z1764034@hopper.cs.niu.edu'
alias turing='ssh z1764034@turing.cs.niu.edu'
alias rypi='ssh pi@10.157.2.85'
alias flick='ssh LuckierDodge@flick.cs.niu.edu'
#alias rypi='ssh pi@172.16.14.9'
#alias rypi='ssh pi@10.157.1.35'
alias alarm='ssh alarm@10.157.2.12'

# ls and grep color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# more ls aliases
alias ll='ls -alhFo'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'

# tmux session alias
alias newmux='tmux new -s Home'
alias oldmux='tmux a -t Home'

# typing is hard
alias c='clear'

#mysql
alias mysql='mysql -h courses -u z1764034 -p z1764034'

#upgrading
alias update='sudo apt update -y && sudo apt upgrade -y'

#Developing on Windows
alias windev='cd /mnt/c/Users/ryand/Dev'

#Jekyll development
alias jekylldo='bundle exec jekyll serve'

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Set PATH to include private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# Set PATH to include current directory
PATH=".:${PATH}"

# Set TERM to support colors
TERM='xterm-256color'

if [ -f "$HOME/.dircolors" ]; then
	eval `dircolors -b "$HOME/.dircolors"`
fi
if [ $(hostname) = "rypi" ]; then
	sudo setvtrgb rypi_colors
fi

# Launch tmux if not already launched
if [ "$TMUX" = "" ]; then
	newmux
fi
if [ "$TMUX" = "" ]; then
	oldmux
fi

source /opt/ros/lunar/setup.bash
source ~/catkin_ws/devel/setup.sh
