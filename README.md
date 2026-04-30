<div align="center">
  <h1>dotfiles × S1M0N38</h1>
</div>

This repository contains my personal dotfiles for macOS Tahoe 26.4, managed using a Git bare repository approach. This minimalist method tracks configuration files in their original locations without symlinks or external tools.

## 🌟 Philosophy

### Git Bare Repository

This dotfiles management approach follows several key principles:

- **Simplicity**: Leverages Git's native capabilities without additional tools
- **No symlinks**: Configuration files remain in their original locations
- **Minimal dependencies**: Doesn't require external dotfile managers or frameworks
- **XDG compliance**: Follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) wherever possible

### Installation Method

All software is installed manually without Homebrew or other package managers:

- **GUI applications**: Downloaded as `.dmg` installers and placed in `/Applications`
- **CLI tools**: Installed via precompiled binaries, `uv tool`, or `npm -g`
- Each application and tool is positioned deliberately with complete control over what exists on the system

## 🚀 Getting Started on a New Machine

### Prerequisites

- Git installed (via Xcode or XCode Command Line Tools)
- SSH key set up for GitHub

### Installation

```bash
# Clone the bare repository
git clone --bare git@github.com:S1M0N38/dotfiles.git $HOME/.dotfiles

# Define the alias temporarily
alias dgit='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Checkout the content (assuming new machine with no conflicting files)
dgit checkout

# Configure the repository to hide untracked files
dgit config --local status.showUntrackedFiles no
```

After installation, the `dgit` and `lgit` aliases will be available in your next shell session since they're defined in `.config/zsh/.zshrc`.

## 🛠️ Managing Dotfiles

### Using `dgit` Command

The `dgit` alias provides a standard Git interface for managing dotfiles:

```bash
# Check status
dgit status

# Add a new configuration file
dgit add ~/.config/some-app/config

# Commit changes
dgit commit -m "Add some-app configuration"

# Push changes to GitHub
dgit push

# Pull updates on another machine
dgit pull
```

> [!CAUTION]
> The work tree is set to `$HOME`, so be cautious when using `dgit` commands. Avoid using `-A` or `--all`. Always specify the exact file or directory you want to add or commit.
>
> ```bash
> # Good
> dgit add ~/.config/specific-file.conf
>
> # Bad (never do this!)
> dgit add -A
> ```


> [!CAUTION]
> Never commit API keys, tokens, passwords, logs or history files, or any sensitive information.


### Using `lgit` Interface

The `lgit` alias provides a terminal-based UI for managing dotfiles using [lazygit](https://github.com/jesseduffield/lazygit):

```bash
# Launch lazygit interface for dotfiles
lgit
```

This provides a user-friendly interface for staging, committing, and managing your dotfiles repository.

## 📦 Installation Guidelines

### Applications

For macOS applications:

1. Download the `.dmg` installer
2. Install the application to `/Applications`
3. Configure as needed

### CLI Tools

For command-line tools:

1. Download the precompiled binary for macOS/ARM64 (or appropriate architecture)
2. Move the binary to `$XDG_BIN_HOME` (`~/.local/bin`)
3. Set executable permissions with `chmod +x $XDG_BIN_HOME/<binary>`
4. If available, move ZSH completions to `$XDG_DATA_HOME/zsh/site-functions`
5. If available, move man pages to `$XDG_DATA_HOME/man/man1`

For multi-binary tools:

1. Move the unzipped directory to `$XDG_DATA_HOME/<tool-name>`
2. Create symlinks from the binaries to `$XDG_BIN_HOME`

---

## ⚡ tau

[**tau**](https://github.com/S1M0N38/tau) is my terminal development environment that provides the WezTerm and tmux configuration layer sitting in my terminal. It includes session management, window management, and pi coding agent integration scripts — all symlinked from `~/Developer/tau/`.

---

## 📋 Included Applications and Tools

### Applications

- [Xcode](https://developer.apple.com/xcode/) - Apple's IDE with developer tools
- [Aerospace](https://github.com/nikitabobko/aerospace) - Tiling window manager for macOS
- [Zen](https://zen-browser.app/) - Firefox-based minimalist browser
- [WezTerm](https://wezfurlong.org/wezterm/) - GPU-accelerated terminal emulator (config via [tau](https://github.com/S1M0N38/tau))

### CLI Programs

The following tools are installed in `$XDG_BIN_HOME` (`~/.local/bin`):

#### Dev Essentials

- [delta](https://github.com/dandavison/delta) - Syntax-highlighting pager for Git
- [direnv](https://direnv.net/) - Environment variable switcher for the shell
- [fd](https://github.com/sharkdp/fd) - Simple, fast and user-friendly alternative to `find`
- [fzf](https://github.com/junegunn/fzf) - Command-line fuzzy finder
- [gh](https://cli.github.com/) - GitHub CLI
- [rg](https://github.com/BurntSushi/ripgrep) - Ripgrep, a fast search tool (grep replacement)
- [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree) - Directory listing as indented tree

#### Languages & Runtimes

- [node](https://nodejs.org/) / [npm](https://www.npmjs.com/) / [npx](https://docs.npmjs.com/cli/v8/commands/npx) - JavaScript runtime and package manager (symlinked from `$XDG_DATA_HOME/nodejs/...`)
- [ruff](https://github.com/astral-sh/ruff) - Fast Python linter and formatter
- [uv](https://github.com/astral-sh/uv) / [uvx](https://github.com/astral-sh/uv) - Python package installer and resolver

#### Terminal & TUI

- [lazydocker](https://github.com/jesseduffield/lazydocker) - Terminal UI for Docker
- [lazygit](https://github.com/jesseduffield/lazygit) - Terminal UI for Git commands
- [tmux](https://github.com/tmux/tmux) - Terminal multiplexer (config via [tau](https://github.com/S1M0N38/tau))
- [zellij](https://zellij.sc/) - Modern terminal workspace

#### AI Coding Agents

- [pi](https://github.com/badlogic/pi-mono) - Coding agent (managed via [tau](https://github.com/S1M0N38/tau))

#### Media

- [ffmpeg](https://ffmpeg.org/) - Audio and video converter
- [sox](https://sox.sourceforge.net/) - Sound eXchange, the Swiss Army knife of audio processing
- [whisper](https://github.com/openai/whisper) - OpenAI speech recognition
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - Command-line video downloader

#### Formatting & Linting

- [biome](https://biomejs.dev/) - Fast formatter and linter for JS/TS/JSON/CSS
- [lua-language-server](https://github.com/LuaLS/lua-language-server) - Lua language server
- [selene](https://github.com/Kampfkarren/selene) - Lua linter
- [shellcheck](https://www.shellcheck.net/) - Shell script static analysis
- [shfmt](https://github.com/mvdan/sh) - Shell script formatter

#### Other

- [aerospace](https://github.com/nikitabobko/aerospace) - CLI for the Aerospace window manager
- [nvim](https://neovim.io/) - Hyperextensible Vim-based text editor
- [starship](https://starship.rs/) - Cross-shell customizable prompt

## 🎨 Font & Theme

- **Font**: [Maple Mono NF](https://github.com/subnut/MapleMono-NF)
- **Theme**: [Tokyo Night Moon](https://github.com/folke/tokyonight.nvim) across WezTerm, tmux, and Neovim

## 📂 Directory Structure

The dotfiles follow the XDG Base Directory Specification:

- `~/.config/` - Application configurations
- `~/.local/share/` - Application data
- `~/.local/state/` - Application state information
- `~/.local/bin/` - User binaries and scripts
- `~/.cache/` - Non-essential cached data

Key configuration directories:

- `~/.config/zsh/` - ZSH configuration
- `~/.config/git/` - Git configuration (SSH commit signing, delta pager)
- `~/.config/lazyvim/` - Neovim configuration (LazyVim distribution with customizations)
- `~/.config/aerospace/` - Aerospace window manager configuration
- `~/.config/gh/` - GitHub CLI configuration
- `~/.config/tmux/` - tmux configuration (→ [tau](https://github.com/S1M0N38/tau))
- `~/.config/lazygit/` - lazygit configuration
- `~/.config/npm/` - npm configuration
- `~/.config/wezterm/` - WezTerm configuration (→ [tau](https://github.com/S1M0N38/tau))
