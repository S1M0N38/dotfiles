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
export CODESTRAL_API_KEY="$(security find-generic-password -a "$USER" -s 'CODESTRAL_API_KEY' -w)"
export OPENROUTER_API_KEY="$(security find-generic-password -a "$USER" -s 'OPENROUTER_API_KEY' -w)"
export COHERE_API_KEY="$(security find-generic-password -a "$USER" -s 'COHERE_API_KEY' -w)"
export GEMINI_API_KEY="$(security find-generic-password -a "$USER" -s 'GEMINI_API_KEY' -w)"
export GROQ_API_KEY="$(security find-generic-password -a "$USER" -s 'GROQ_API_KEY' -w)"
export GITHUB_API_KEY="$(security find-generic-password -a "$USER" -s 'GITHUB_API_KEY' -w)"
export DEEPGRAM_API_KEY="$(security find-generic-password -a "$USER" -s 'DEEPGRAM_API_KEY' -w)"
export CEREBRAS_API_KEY="$(security find-generic-password -a "$USER" -s 'CEREBRAS_API_KEY' -w)"
export HF_TOKEN="$(security find-generic-password -a "$USER" -s 'HF_TOKEN' -w)"
export CONTEXT7_API_KEY="$(security find-generic-password -a "$USER" -s 'CONTEXT7_API_KEY' -w)"
export OPENROUTER_API_KEY="$(security find-generic-password -a "$USER" -s 'OPENROUTER_API_KEY' -w)"
export OPENCLAW_GATEWAY_TOKEN="$(security find-generic-password -a "$USER" -s 'OPENCLAW_GATEWAY_TOKEN' -w)"
export ZAI_API_KEY="$(security find-generic-password -a "$USER" -s 'ZAI_API_KEY' -w)"

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

# Use emacs keybindings in command mode
bindkey -e

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

# Android / Java development
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/Users/simo/.bun/_bun" ] && source "/Users/simo/.bun/_bun"
