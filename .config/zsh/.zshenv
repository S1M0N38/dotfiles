export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"

export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"
export UV_PYTHON_PREFERENCE="only-managed"

export EDITOR="nvim"

# Add XDG_BIN_HOME to PATH if not already present
if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
    export PATH="$XDG_BIN_HOME:$PATH"
fi
