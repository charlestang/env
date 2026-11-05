# Agent guide

Personal machine environment for Charles: shell, Vim, CLI helpers, Surge rules, and Rime input.
Clone to `~/env` and wire into the home directory via symlinks / sourcing. This is not an application service.

## Prefer changing

| Area | Paths |
| --- | --- |
| Shell | `.zshrc`, `.bashrc`, `.alias`, `.global_export`, `.bash_git_alias` |
| Vim | `.vimrc`, `vim/plugin.vim`, `vim/plugin-vimr.vim` |
| Tools | `bin/`, `scripts/`, `mac/` |
| Proxy / IME | `surge/`, `rime-config/` |
| Bootstrap | `install.sh`, root docs (`README.md`, this file, `SECURITY.md`) |

Machine-specific overrides belong **outside** the repo:

- `~/.zshrc.local`
- `~/.alias`
- `~/.local_export`

Do not hardcode those into committed files.

## Do not change (unless explicitly asked)

- Git submodules and their trees: `oh-my-zsh/`, `bash-it/`, `vim/vim-plug/`, and any other submodule content
- Secrets, tokens, private keys, or personal host inventories
- Unrelated files in the same commit

Bump a submodule only when the user asks to upgrade that dependency.

## Conventions

- Use `$HOME` or `$ENV_BASE_PATH` for paths. Never hardcode `/Users/<username>/`.
- Keep shared aliases and exports in `.alias` / `.global_export`; keep per-machine tweaks in the local overlay files above.
- `install.sh` mutates the home directory (backup + symlink/source). Document that behavior when changing install logic.
- For Surge, prefer editing `surge/ruleset/*.list`. Touch `surge/config.ini` only for groups or ruleset references.
- Prefer the smallest change that solves the request. Do not refactor vendored frameworks.

## How to verify

- Shell: `zsh -n .zshrc` (and `bash -n .bashrc` if bash files changed), or open a new terminal / `source` the relevant file.
- Scripts: run the changed `bin/*` helper with a dry check (`--help`, no-op, or equivalent).
- Vim: open Vim and confirm `:scriptnames` / plugin load if plugin lists changed.
- Do not run full submodule test suites unless the user asks.

## Git

- Stage only files related to the task.
- Do not commit directly to the default branch when a feature branch / PR is expected.
- Say which layer changed in the commit or PR summary (shell, vim, surge, docs, etc.).
