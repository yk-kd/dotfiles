
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' use-cache yes
zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME}/zsh/zcompcache

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;2;38;41;64;38;2;130;143;237;1'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion:*:manuals' separate-sections true
zmodload -i zsh/complist

autoload -Uz cdr
autoload -Uz history-search-end
autoload -Uz modify-current-argument
autoload -Uz smart-insert-last-word
autoload -Uz terminfo
autoload -Uz vcs_info
autoload -Uz zcalc
autoload -Uz zmv
autoload -Uz run-help-git
autoload -Uz run-help-svk
autoload -Uz run-help-svn


if type carapace &>/dev/null; then
  export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
  zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
  source <(carapace _carapace)
  zstyle ':completion:*:git:*' group-order 'alias commands' 'main commands' 'external commands'
fi
