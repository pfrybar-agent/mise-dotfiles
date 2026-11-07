# -*- mode: sh -*-
#
# Executes commands at the start of an interactive session.
#

# ensure function paths do not contain duplicates.
typeset -gU fpath

# define aliases
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias gs='git status'
alias gsu='git submodule update'
alias kc='kubectl'
alias kx='kubectx'

# tinted-shell
[ -s "$HOME/.tinted-shell" ] && source "$HOME/.tinted-shell"

# asdf
asdf_dir="${ASDF_DATA_DIR:-$HOME/.asdf}"
[ -d "$asdf_dir/completions" ] && fpath=("$asdf_dir/completions" $fpath)

# asdf java - set JAVA_HOME
[ -s "$asdf_dir/plugins/java/set-java-home.zsh" ] && source "$asdf_dir/plugins/java/set-java-home.zsh"

# prezto
prezto_dir="${ZDOTDIR:-$HOME}/.zprezto"
[ -s "$prezto_dir/init.zsh" ] && source "$prezto_dir/init.zsh"

# atuin
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# local zshrc
[ -s "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
