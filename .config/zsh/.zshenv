# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="nvim"

# uv
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
export UV_PYTHON_PREFERENCE="only-managed"

# rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# zsh
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

# Add XDG_BIN_HOME to PATH if not already present
if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
    export PATH="$XDG_BIN_HOME:$PATH"
fi

# Add rust cargo bin directory to PATH if not already present
if [[ ":$PATH:" != *":$CARGO_HOME/bin:"* ]]; then
    export PATH="$CARGO_HOME/bin:$PATH"
fi
