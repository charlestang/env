# Security

## Scope

This repository is a **personal dotfiles / local tooling** tree. Config here is loaded by the login shell, editors, and (optionally) proxy/IME clients on a single machine. There is no hosted service and no public API. The trust boundary is the local user account that installs and sources these files.

## Do not commit

- SSH or GPG private keys, cloud credentials, API tokens, `.env` files with secrets
- Password store dumps or clipboard history
- Host inventories with real accounts (e.g. `~/server_list/config.yaml` used by `goto` — keep that outside the repo)
- Unredacted internal hostnames, VPN secrets, or company credentials

If something sensitive is committed by mistake: rotate the credential immediately and remove it from git history before treating the leak as closed.

## Sensitive surfaces in this repo

| Surface | Risk |
| --- | --- |
| `install.sh` | Rewrites `~/.bashrc` / `~/.vimrc` (with backup) and may symlink into system paths (e.g. iTerm zmodem helpers). Review before running. |
| `bin/online` | Expects elevated privileges; changes file ownership under a deploy directory. |
| `bin/goto` | Talks to hosts listed in an **external** YAML config; do not vendor that list here. |
| `surge/` | Proxy routing and domain lists. On a public remote, treat company/internal domains as information disclosure risk. |
| Submodules (`oh-my-zsh`, `bash-it`, `vim-plug`, …) | Report or track upstream security issues in those projects; do not patch upstream trees in place unless intentional. |

## Hardening expectations

- Put secrets and machine-only paths in `~/.zshrc.local`, `~/.alias`, or `~/.local_export`, not in tracked files.
- Prefer `$HOME` / `$ENV_BASE_PATH` over absolute home paths so configs do not leak a username and remain portable.
- Keep `.gitignore` excluding local/generated junk; extend it when a new local secret path appears.
- Run `install.sh` and privileged helpers only on machines you control, after reading the script.

## Reporting

This is a personal repository. Report security concerns privately to the repository owner (GitHub security advisory or direct contact). There is no bug bounty and no fixed SLA.

Upstream issues in submodules should be reported to those upstream projects when appropriate (for example, [ohmyzsh/ohmyzsh SECURITY](https://github.com/ohmyzsh/ohmyzsh/blob/master/SECURITY.md)).
