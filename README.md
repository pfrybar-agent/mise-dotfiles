# Mise Dotfiles

Configuration for macOS and Linux environments using Mise for package
installation and dotfile configuration.

## Installation

### Mise only

mise -E personal bootstrap \
  --from https://github.com/pfrybar/mise-dotfiles.git \
  --from-dir ~/.dotfiles \
  --config-dir . \
  --save-env

### Full macOS setup

This sequence assumes a fresh machine, with the SSH signing key at
`~/.ssh/git_signing_key`.

```sh
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

curl -fsSL https://raw.githubusercontent.com/pfrybar/mise-dotfiles/main/Brewfile | brew bundle install --file=-

# if installing on a work laptop, exclude '-E personal' and '--save-env'
mise -E personal bootstrap \
  --from https://github.com/pfrybar/mise-dotfiles.git \
  --from-dir ~/.dotfiles \
  --config-dir . \
  --save-env

ZSH_PATH="$(command -v zsh)"
grep -qxF "$ZSH_PATH" /etc/shells || printf '%s\n' "$ZSH_PATH" | sudo tee -a /etc/shells
chsh -s "$ZSH_PATH"
```

## Updating

### Brew packages

```sh
brew update && brew upgrade && brew cleanup
```

### Mise packages
```sh
mise upgrade
```

### zprezto
```sh
mise bootstrap repos update ~/.zprezto
```

## Tests

GitHub Actions checks the installer on Linux and macOS, including the Apple
Silicon Homebrew environment. It also tests configuration syntax, Git, Emacs,
Emacs package installation, Claude Code onboarding, tmux, Prezto startup, and
Atuin initialization.
See the workflow for details.
