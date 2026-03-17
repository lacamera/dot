# macOS Terminal Setup

[Homebrew](https://brew.sh/) is the missing package manager for macOS. The `setup.sh` script in this repository will install Homebrew and a suite of essential terminal utilities for you.

Make sure you have the Xcode Command Line Tools installed:  
```sh
xcode-select --install
```

Next, install Homebrew itself:  
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Initialize Homebrew in your shell:  
```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

```sh
brew install koekeishiya/formulae/skhd
./quartz/setup
skhd --start-service
```

This repo ships a default `skhd` binding:

```text
shift + alt - t
```

That hotkey toggles macOS Light/Dark appearance and then reloads tmux so your synced Gruvbox light/dark themes follow along.

After installation:

```sh
skhd --reload
```

You will also need to grant Accessibility permissions to `skhd` in:

```text
System Settings -> Privacy & Security -> Accessibility
```

Notes:
- WezTerm should follow macOS appearance automatically
- tmux is reloaded by the toggle script
- Neovim updates on focus/resume, or immediately with `:ThemeSync`
