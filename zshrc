# The following lines were added by compinstall
zstyle :compinstall filename '/home/constantin/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
setopt HIST_IGNORE_SPACE
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

export PATH="$HOME/.cargo/bin:$PATH"
export WINEDLLOVERRIDES="winemenubuilder.exe=d;mscoree=d;mshtml=d"

eval "$(starship init zsh)"

# Aliases
alias chmod='chmod -c'
alias chown='chown -c'
alias gitk=tig

alias t='todo.sh'
alias i='TODO_TYPE=ideas todo.sh'
