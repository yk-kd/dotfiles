export BREW_PATH="/opt/homebrew"
typeset -gx -U path
path=( \
    ~/.bun/bin(N-/) \
    ~/.local/bin(N-/) \
    /usr/local/bin(N-/) \
    $BREW_PATH/opt/openjdk/bin(N-/) \
    $BREW_PATH/opt/python/libexec/bin(N-/) \
    $BREW_PATH/opt/llvm/bin/(N-/) \
    $BREW_PATH/opt/ruby/bin(N-/) \
    ${BREW_PATH}/bin(N-/) \
    $BREW_PATH/sbin(N-/) \
    ~/.moon/bin(N-/) \
    /snap/bin(N-/) \
    ~/.local/share/coursier/bin(N-/) \
    ~/go/bin(N-/) \
    ~/.dotnet/tools(N-/) \
    ~/.cargo/bin(N-/) \
    ~/.tmux/bin(N-/) \
    ~/.bun/bin(N-/) \
    ~/.cache/.bun/bin(N-/) \
    ~/.dotnet(N-/) \
    ~/Library/Android/sdk/platform-tools(N-/) \
    "$path[@]" \
)

typeset -gx -U fpath
fpath=( \
    $BREW_PATH/share/zsh/site-functions(N-/) \
    $fpath \
)

# force /etc/z* files after /etc/zshenv to be skipped.
setopt no_global_rcs

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZCACHEDIR=$XDG_CACHE_HOME/zsh
export NVIM_APPNAME="LazyVim"

export PATH="$PATH:$HOME/.puro/bin" # Added by Puro
export PATH="$PATH:$HOME/.puro/shared/pub_cache/bin" # Added by Puro
export PATH="$PATH:$HOME/.puro/envs/default/flutter/bin" # Added by Puro
export PURO_ROOT="/Users/yousuke.komada.789/.puro" # Added by Puro

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"


