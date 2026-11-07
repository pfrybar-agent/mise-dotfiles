#!/usr/bin/env bash
set -euo pipefail

# install the emacs packages selected in emacs. once they are all installed this
# does nothing and does not contact the package archives, so it is safe to rerun.
install_emacs_packages() {
    command -v emacs >/dev/null || return 0

    # base16-theme prints a compile warning for each of its themes, so only show
    # the emacs output when the installation fails.
    local output
    if ! output="$(emacs --batch --eval '(package-initialize)' --load "$HOME/.emacs" --eval '
        (unless (cl-every (function package-installed-p) package-selected-packages)
          (package-refresh-contents)
          (package-install-selected-packages t))' 2>&1)"; then
        printf '%s\n' "$output" >&2
        return 1
    fi
}

install_emacs_packages
