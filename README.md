# dot.nix

macOS-first dotfiles scaffolded for a `nix-darwin` + `home-manager` migration.

## Layout

- `flake.nix`: entry point for the Nix configuration
- `hosts/macbook`: host-specific system and home imports
- `modules/darwin`: macOS system modules for `nix-darwin`
- `modules/home`: user-level modules for `home-manager`
- `modules/shared`: shared defaults and package placeholders
- `config/darwin`: raw macOS app configs
- `config/home`: raw user config files managed by Home Manager
- `archive`: retired Linux, font, and legacy setup assets

## Current Scope

- Active target: macOS
- Archived: `archive/i3wm`, `archive/fonts`
- Legacy symlink installers kept only for reference in `archive/legacy`

## First Pass Bootstrap

1. Install Nix and enable flakes.
2. Update `flake.nix` if your username, host name, or architecture differ from the scaffold defaults.
3. Build the host with:

```sh
darwin-rebuild switch --flake .#macbook
```

## Notes

- This is a structure-first migration, not a fully customized package manifest yet.
- Existing config sources now live under `config/` so modules can stay small and declarative.
- `git`, `ssh`, `tmux`, `neovim`, `aerospace`, `skhd`, and `mpv` are now primarily declared through Home Manager modules.
- `wezterm`, `opencode`, and most of `bash` still use sourced files where that is simpler.
