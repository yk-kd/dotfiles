
typeset -gx -U path
path=( \
    ~/.local/bin(N-/) \
    /usr/local/opt/python/libexec/bin(N-/) \
    /usr/local/opt/llvm/bin/(N-/) \
    /usr/local/opt/ruby/bin(N-/) \
    /usr/local/bin(N-/) \
    /usr/local/sbin(N-/) \
    /snap/bin(N-/) \
    ~/.local/share/coursier/bin(N-/) \
    ~/go/bin(N-/) \
    ~/.dotnet/tools(N-/) \
    ~/.cargo/bin(N-/) \
    ~/.tmux/bin(N-/) \
    ~/.dotnet(N-/) \
    ~/Library/Android/sdk/platform-tools(N-/) \
    "$path[@]" \
)

typeset -gx -U fpath
fpath=( \
    /usr/local/share/zsh/site-functions(N-/) \
    $fpath \
)

# force /etc/z* files after /etc/zshenv to be skipped.
setopt no_global_rcs

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZCACHEDIR=$XDG_CACHE_HOME/zsh
