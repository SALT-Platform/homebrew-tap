# SALT-Platform Homebrew tap

Homebrew casks for SALT desktop apps.

```bash
brew install --cask salt-platform/tap/salt-code
```

| Cask | App | What it is |
|---|---|---|
| `salt-code` | SALT Code (Beta).app | Desktop shell for the SALT Platform local stack (Apple silicon and Intel, macOS 13 or later) |

SALT Code opens the SALT Platform running on your own Mac (`http://localhost:5173`).
It does not start any services, so set up the local stack first. SALT staff: follow
[docs/guides/salt-code-desktop.md](https://github.com/SALT-Platform/salt-platform/blob/main/docs/guides/salt-code-desktop.md)
in SALT-Platform/salt-platform.

## Why the command names the tap

Homebrew 7 only loads casks from taps you trust. Installing by the full name
`salt-platform/tap/salt-code` taps this repository and trusts that one cask in the
same step (`==> Trusted cask salt-platform/tap/salt-code`). The short form
`brew install --cask salt-code` is refused until the cask is trusted
(`brew trust --cask salt-platform/tap/salt-code`).

## Uninstall

```bash
brew uninstall --cask salt-code          # remove the app
brew uninstall --zap --cask salt-code    # also remove its settings and sign-in data
```

## How releases get here

`Casks/salt-code.rb` and the release zips are produced by
`apps/desktop/scripts/release-mac.sh --publish` in SALT-Platform/salt-platform (Spec 3030).
Do not edit the cask by hand. Until SALT has an Apple Developer ID, builds are ad-hoc signed
and the cask clears the download quarantine after install; a notarized release drops that step.
The `tests` workflow installs the cask on clean GitHub-hosted Macs (Apple silicon and Intel)
on every change and every week.
