# Add binaries in ~/.local/bin to $PATH
source "$HOME/.local/bin/env"

# Aliases
alias git-dots="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias lgit-dots="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit"
