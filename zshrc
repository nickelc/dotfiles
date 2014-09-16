# The following lines were added by compinstall
zstyle :compinstall filename '/home/constantin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

alias t='todo.sh'
alias i='TODO_TYPE=ideas todo.sh'
alias yaourt='PAGER="less -FSRX" yaourt --color'
