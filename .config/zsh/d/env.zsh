
REPORTTIME=3


if [[ -d "$HOME/.poetry/bin/" ]]; then
  export PATH="$HOME/.poetry/bin/:$PATH"
fi

if hash yarn 2>/dev/null; then
  export PATH="$PATH:$(yarn global bin)"
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# available $INTERACTIVE_FILTER
export INTERACTIVE_FILTER="fzf:peco:percol:gof:pick"

export FZF_DEFAULT_OPTS='
--extended
--ansi
--multi
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
--bind=ctrl-z:toggle-all
'
