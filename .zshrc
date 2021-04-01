# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/constantin/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_SPACE
unsetopt nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

export EDITOR=nvim
export PATH="$HOME/.cargo/bin:$PATH"
export WINEDLLOVERRIDES="winemenubuilder.exe=d;mscoree=d;mshtml=d"

prompt off
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd y)"

source $HOME/.config/broot/launcher/bash/br

# Keymaps for the idiotic keyboard layout
bindkey -s ł '|'
bindkey -s » '<'
bindkey -s « '>'

# Aliases
alias chmod='chmod -c'
alias chown='chown -c'
alias gitk=tig
alias vim=nvim
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
