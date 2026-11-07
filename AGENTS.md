# AGENTS.md

Dotfiles and user tools for macOS and Linux, applied with mise. `mise bootstrap`
clones this repo to `~/.dotfiles`, makes it mise's global config, installs the
tools, copies the dotfiles into `~` and runs `post-install.sh`. `README.md` is
for people setting up a machine.

## Layout

- `config.toml`: tools for every machine, the Prezto clone, the dotfiles copy
  and the `bootstrap` task.
- `config.workbench.toml`, `config.personal.toml`: extra tools for
  `mise -E workbench` (coding agents) and `mise -E personal`.
- `home/dot-*`: copied to `~/.*`, so `home/dot-zshrc` becomes `~/.zshrc`. Edit
  them here: the next bootstrap overwrites edits made in `~`.
- `post-install.sh`: the `bootstrap` task. It runs on every bootstrap, so keep
  it safe to rerun and quiet when it succeeds.
- `Brewfile`: what macOS needs before mise takes over.
- `home/dot-tinted-shell` is vendored: update it from upstream, don't edit it.

## Test

```sh
bash -n post-install.sh && shellcheck post-install.sh
for file in home/dot-zshenv home/dot-zprofile home/dot-zshrc \
            home/dot-zpreztorc home/dot-zlogin home/dot-zlogout; do
    zsh -n "$file"
done
git config --file home/dot-gitconfig --list >/dev/null
```

A full bootstrap into a throwaway home (needs the network; `--from` clones the
committed state, so commit first):

```sh
home=$(mktemp -d)
HOME=$home mise bootstrap --from "$PWD" --from-dir "$home/.dotfiles" --config-dir . --yes
```

`.github/workflows/test.yml` bootstraps a fresh home on Ubuntu 26.04 (the
workbench image's release) and macOS, then checks Git, Emacs, tmux, Prezto and
Atuin. Update it with any change in behavior.

## Rules

- Everything must work on macOS and Linux, including the workbench image.
- Secrets never go in the repository. Machine-specific settings belong in
  `~/.gitconfig.local` and `~/.zshrc.local`; keep the include of
  `~/.gitconfig.local` last in `home/dot-gitconfig`.
- Shell scripts use Bash with `set -euo pipefail`, 4-space indentation and
  short lowercase comments. Zsh files start with `# -*- mode: sh -*-`.
- Wrap Markdown prose at 80 columns.

## Commits and pull requests

- Commit on a branch, never `main`. Write a single short imperative subject
  line with no body, such as `Install Emacs packages with post-install.sh`.
- End the message with a `Co-Authored-By` trailer naming the agent and model,
  such as `Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>`.
- Commits are SSH-signed. If signing fails, stop and report it; don't use
  `--no-gpg-sign`.
- You can't push to `origin`. Push to your account's fork and open a pull
  request; the maintainer reviews and merges it:

  ```sh
  gh repo fork --remote --remote-name fork      # once per clone
  gh repo set-default pfrybar/mise-dotfiles     # once per clone
  git push -u fork HEAD
  gh pr create --fill
  ```
