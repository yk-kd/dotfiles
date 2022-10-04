
REPORTTIME=3

# dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1


export COURSIER_BIN_DIR="$HOME/.local/share/coursier/bin"
export PATH="$COURSIER_BIN_DIR:$PATH"


# available $INTERACTIVE_FILTER
export INTERACTIVE_FILTER="fzf:peco:percol:gof:pick"

export EZA_ICONS_AUTO=1

export FZF_DEFAULT_OPTS='
--extended
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'

eval "$(mise activate zsh)"
