# zsh hist
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

# Add zsh functions to $fpath
# fpath=("$XDG_DATA_HOME/zsh/site-functions" $fpath)

# Load completion system
fpath+=$XDG_CONFIG_HOME/zsh/functions
fpath+=$HOME/.zfunc
autoload -Uz compinit
compinit

# Aliases
alias ll='ls -lah --color=auto'
alias lvim="NVIM_APPNAME=lazyvim nvim"
alias dgit="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias mvim="NVIM_APPNAME=nvim-minimax nvim"

# Secrets
# To add a new secret, use:
# security add-generic-password -a "$USER" -s 'SECRET_KEY' -w 'SECRET_VALUE' -U

# Lua
export LUA_DIR="$HOME/Developer/lua"
export PATH="$PATH:${LUA_DIR}/bin"
export LUA_CPATH="${LUA_DIR}/lib/lua/5.1/?.so"
export LUA_PATH="${LUA_DIR}/share/lua/5.1/?.lua;;"
export MANPATH="${LUA_DIR}/share/man:$MANPATH"

# LuaRocks
export PATH="$PATH:$HOME/.luarocks/bin"
eval $(luarocks path --no-bin)

# Functions
function lgit() {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    GIT_DIR="$HOME/.dotfiles" GIT_WORK_TREE="$HOME" lazygit
  else
    lazygit
  fi
}

# enable vi mode
# bindkey -v
# export KEYTIMEOUT=1
#
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]]; then
#     echo -ne '\e[1 q'
#   elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]]; then
#     echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select
#
# function vi-yank-xclip {
#     zle vi-yank
#     echo "$CUTBUFFER" | pbcopy
# }
# zle -N vi-yank-xclip
#
# bindkey -M vicmd ' y' vi-yank-xclip
# bindkey -M visual ' y' vi-yank-xclip

# fzf Developer repo picker widget (CRTL+X O)
dev_repo_picker_widget() {
  local script_path="/Users/simo/.local/bin/dev-repo-open"
  if [ -x "$script_path" ]; then
    "$script_path"
  else
    echo "Script not found: $script_path"
  fi
  zle reset-prompt
}
zle -N dev_repo_picker_widget
bindkey '^xo' dev_repo_picker_widget

# # Use emacs keybindings in command mode
bindkey -e

# Edit command line with CTRL-X E
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
zvm_after_init_commands+=("source $XDG_CONFIG_HOME/fzf/fzf.zsh")

# direnv
eval "$(direnv hook zsh)"

# Prompt
eval "$(starship init zsh)"

# ty
eval "$(ty generate-shell-completion zsh)"

# Cursor Agent
# eval "$(~/.local/bin/cursor-agent shell-integration zsh)"

# Android / Java development
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/Users/simo/.bun/_bun" ] && source "/Users/simo/.bun/_bun"

