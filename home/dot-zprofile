# -*- mode: sh -*-
#
# Executes commands at login pre-zshrc.
#

#
# Editors
#

export EDITOR='emacs'
export VISUAL='emacs'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Homebrew
#

# Set Homebrew's environment without invoking brew during shell startup.
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX='/opt/homebrew'
  export HOMEBREW_CELLAR='/opt/homebrew/Cellar'
  export HOMEBREW_REPOSITORY='/opt/homebrew'

  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
  export FPATH

  if [[ -n "${MANPATH-}" ]]; then
    export MANPATH="${MANPATH%"${MANPATH##*[!:]}"}"
    export MANPATH=":${MANPATH#"${MANPATH%%[!:]*}"}"
  fi

  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/.local/{,s}bin(N)
  "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  $HOME/{,s}bin(N)
  /opt/homebrew/{,s}bin(N)
  /opt/local/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -X -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
