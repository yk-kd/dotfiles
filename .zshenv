
typeset -gx -U path
path=( \
    /usr/local/opt/python/libexec/bin(N-/) \
    /usr/local/opt/llvm/bin/(N-/) \
    /usr/local/opt/ruby/bin(N-/) \
    /usr/local/bin(N-/) \
    ~/bin(N-/) \
    ~/go/bin(N-/) \
    ~/.local/bin(N-/) \
    ~/.cargo/bin(N-/) \
    ~/.poetry/bin(N-/) \
    ~/.tmux/bin(N-/) \
    ~/Library/Android/sdk/platform-tools(N-/) \
    "$path[@]" \
    )


# force /etc/z* files after /etc/zshenv to be skipped.
setopt no_global_rcs

export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

