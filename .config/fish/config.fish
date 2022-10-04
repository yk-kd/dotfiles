set -gx LC_ALL "en_US.UTF-8"
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache

fish_add_path $HOME/.local/bin
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path /usr/local/opt/curl/bin

#if not command -q fisher
#  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update
#end

alias ls eza
alias la "eza -a"
alias ll "eza -l"
alias lla "eza -la"
alias v nvim
alias g git
if command -q gomi
  alias rm gomi
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
