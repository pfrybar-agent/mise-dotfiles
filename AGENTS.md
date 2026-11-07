# Agent guide

Symlink-based dotfiles for macOS and Linux: Zsh with Prezto, Git, tmux, Emacs,
asdf, Atuin, and a Tomorrow Night terminal palette. `README.md` documents the
setup in detail; read it before changing behavior.

## Layout

- `install.sh` links every top-level file into `$HOME` as `.<name>`, so `zshrc`
  becomes `~/.zshrc`. A new file at the root that is not a dotfile must be added
  to the skip list in `install.sh`, the skipped-files list in `README.md`, and
  the `test ! -e` checks in the workflow.
- `post-install.sh` holds slower setup that needs the network, such as
  installing Emacs packages. The workbench image runs it on every container
  start, so it must be safe to rerun and quiet when it succeeds.
- `Brewfile` lists the macOS packages.
- `tinted-shell` is vendored. Update it from upstream rather than editing or
  reformatting it.
- Credentials and secrets never go in the repository. `gitconfig` holds the
  default Git identity, and machine-specific settings belong in
  `~/.gitconfig.local` and `~/.zshrc.local`. Keep the include of
  `~/.gitconfig.local` at the end of `gitconfig` so it can override the rest.

## Compatibility

- Everything must work on both macOS and Linux.
- Stay compatible with the minimum versions in `README.md`: Git 2.37, tmux 3.5,
  Emacs 27, and standalone asdf 0.16.

## Style

- Shell scripts use Bash with `set -euo pipefail`, 4-space indentation, and
  short lowercase comments.
- Zsh files start with the `# -*- mode: sh -*-` header.
- Wrap Markdown prose at 80 columns.

## Testing

`.github/workflows/test.yml` tests the configuration on Linux and macOS. Update
it with any change in behavior. Before committing, run at least:

```sh
bash -n install.sh && bash -n post-install.sh
shellcheck install.sh post-install.sh
for file in zshenv zprofile zshrc zpreztorc zlogin zlogout; do
    zsh -n "$file"
done
```

## Commits

- Write a single short imperative subject line with no body, such as
  `Install Emacs packages with post-install.sh`.
- End the message with a `Co-Authored-By` trailer naming the agent and model,
  such as `Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>` or
  `Co-Authored-By: GPT-5.6 Codex <noreply@openai.com>`.
- Commits are SSH-signed. If signing fails, stop and report it instead of
  committing with `--no-gpg-sign`.
- Commit on a branch, never `main`.
- You cannot push to `origin`: your GitHub token belongs to an account without
  write access. Push to that account's fork and open a pull request; the
  maintainer reviews and merges it.

  ```sh
  # once per clone: add the fork (created if missing) as `fork`, and make
  # pfrybar/mise-dotfiles the repo that pull requests target
  gh repo fork --remote --remote-name fork
  gh repo set-default pfrybar/mise-dotfiles

  git push -u fork HEAD
  gh pr create --fill
  ```
