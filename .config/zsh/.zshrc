# Add binaries in ~/.local/bin to $PATH
source "$XDG_BIN_HOME/env"

# Add zsh functions to $fpath
fpath=("$XDG_DATA_HOME/zsh/site-functions" $fpath)

# Load completion system
autoload -Uz compinit
compinit

# Aliases
alias ll='ls -lah --color=auto'
alias lgit='lazygit'
alias lvim="NVIM_APPNAME=lazyvim nvim"
alias git-dots="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias lgit-dots="GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME lazygit"

# starship prompt
eval "$(starship init zsh)"
