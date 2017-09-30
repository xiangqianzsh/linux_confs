# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
export JAVA_HOME=/usr/bin/java/

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Check for an interactive session
[ -z "$PS1" ] && return

alias grep='grep --color=auto'
alias vi='vim --noplugin'
alias ls='ls -G'
alias ll='ls -lht -G'
alias l='ls -lht -G'
alias git='http_proxy= https_proxy= git'
alias p='python'

bind 'set show-all-if-ambiguous on'

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export GREP_COLOR="1;33"
export EDITOR="vim"
export VISUAL="vim"
export PYTHONIOENCODING=UTF-8

#set java home
JAVA_HOME=`/usr/libexec/java_home`  
export JAVA_HOME  

PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[m\]\[\e[0;32m\] '

