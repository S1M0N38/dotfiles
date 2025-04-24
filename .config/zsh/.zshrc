# Add binaries in ~/.local/bin to $PATH
source "$XDG_BIN_HOME/env"

# Add zsh functions to $fpath
fpath=("$XDG_DATA_HOME/zsh/site-functions" $fpath)

# Load completion system
autoload -Uz compinit
compinit

# Aliases
alias ll='ls -lah --color=auto'
alias lvim="NVIM_APPNAME=lazyvim nvim"
alias dgit="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Functions
function lgit() {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    GIT_DIR="$HOME/.dotfiles" GIT_WORK_TREE="$HOME" lazygit
  else
    lazygit
  fi
}

# Prompt
eval "$(starship init zsh)"
