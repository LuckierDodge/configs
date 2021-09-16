# .bashrc

# Make a .bash_environment file to store machine specific variables
if [ -f "$HOME/.bash_environment" ]; then
	source $HOME/.bash_environment
fi

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

source $HOME/.aliases

if [ "$START_TMUX" = "TRUE" ] && [ "$TMUX" = "" ]; then
	#  Launch tmux if not already launched and create a new session
	tmux has-session -t Home 2>/dev/null
	if [ $? != 0 ]; then
		homemux
	else
		homemuxnew
	fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/luckierdodge/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/luckierdodge/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/luckierdodge/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/luckierdodge/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Prompt Colors
Red='\[\e[01;31m\]'
Green='\[\e[01;32m\]'
Yellow='\[\e[01;33m\]'
Blue='\[\e[01;34m\]'
Purple='\[\e[01;35m\]'
Cyan='\[\e[01;36m\]'
White='\[\e[01;37m\]'
Reset='\[\e[00m\]'

# Fetches the git branch
git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Add prompt info for git branch
git_prompt()
{
	if [ -n "$(git_branch)" ]; then
		# If we're in a git branch, 
		# print branch name with color indicating whether or not it's clean
		if [[ $(git st) == "" ]]; then
			echo "$White.$Green$(git_branch)"
		else
			echo "$White.$Yellow$(git_branch)"
		fi
	else
		echo ""
	fi
}

# Add prompt info for conda environment
conda_env()
{
	if [[ -z "$CONDA_DEFAULT_ENV" ]]; then
		echo ""
	else
		echo "${White}«$Purple$CONDA_DEFAULT_ENV${White}»"
	fi
}

# Print different colored prompt terminator depending on exit code of previous command
exit_prompt()
{
	if [[ $? -eq 0 ]]; then
		echo "$Green♪"
	else
		echo "$Red♪"
	fi
}

# Add prompt info for docker container
docker_prompt()
{
	if [[ -z "$CONTAINER_NAME" ]]; then
		echo "$Blue\h"
	else
		echo "$Purple$CONTAINER_NAME$White→${Red}\h$White"
	fi
}

# Command run to display prompt
set_prompt ()
{
	exit_code="$(exit_prompt)"
	PS1="$Cyan\u$White@$(docker_prompt)$White($Cyan\w$(git_prompt)$White)$(conda_env)$exit_code $Reset"
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

if [ -f "~/.ssh/id_ed25519" ]; then
	# Check if the ssh-agent is already running
	if [[ "$(ps -u $USER | grep ssh-agent | wc -l)" -lt "1" ]]; then
		#echo "$(date +%F@%T) - SSH-AGENT: Agent will be started"
		# Start the ssh-agent and redirect the environment variables into a file
		ssh-agent -s -t 7d > ~/.ssh/ssh-agent
		# Load the environment variables from the file
		. ~/.ssh/ssh-agent > /dev/null
		# Add the default key to the ssh-agent
		ssh-add ~/.ssh/id_ed25519
	else
		#echo "$(date +%F@%T) - SSH-AGENT: Agent already running"
		. ~/.ssh/ssh-agent > /dev/null
	fi
fi
