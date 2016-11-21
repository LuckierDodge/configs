# .bash_aliases

# ssh aliases
alias tiger='ssh z1764034@tiger.cs.niu.edu'
alias hopper='ssh z1764034@hopper.cs.niu.edu'
alias turing='ssh z1764034@turing.cs.niu.edu'
alias rypi='ssh pi@10.157.1.69'
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

# tmux session alias
alias mux='tmux new -s Home'

# typing is hard
alias c='clear'

#mysql
alias mysql='mysql -h courses -u z1764034 -p z1764034'
