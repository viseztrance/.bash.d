# Change directories without typing cd
shopt -s autocd

# Store multiline commands to history as a single command
shopt -s cmdhist

# Don't override history
shopt -s histappend

export HISTFILESIZE=50000
export HISTSIZE=10000
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:ls:[bf]g:exit"
export TERM="xterm-256color"
export EDITOR="vim"
