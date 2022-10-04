# ls
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
# process
# alias j="jobs -l"
alias 'ps?'='pgrep -l -f'
alias pk='pkill -f'

# du/df
alias du="du -h"
alias df="df -h"
alias duh="du -h ./ --max-depth=1"
# su
alias su="su -l"
# vim
alias v='nvim'
alias 'src'='exec zsh'
alias -g V="| nvim -"
alias -g EV="| xargs --verbose sh -c 'nvim \"\$@\" < /dev/tty'"
# emacs
alias emacs='TERM=xterm-24bit emacs'
alias e='TERM=xterm-24bit emacsclient -nw -a ""'
alias ekill='emacsclient -e "(kill-emacs)"'

alias pipup='pip3 list -o|tail -n +3|cut -d" " -f1|tr "\n" " "|xargs pip3 install -U'

# less
alias less='less -r'
# grep
alias gr='grep --color=auto -ERUIn'
#make
alias 'm'='make'
alias 'mn'='make native-code'
alias 'mc'='make clean'
# tmux
#alias tmux='tmux attach || tmux new-session'
alias tm='tmux'
alias tma='tmux attach'
alias tma0='tmux attach -t 0'
alias tma1='tmux attach -t 1'
alias tma2='tmux attach -t 2'
alias tml='tmux list-sessions'

alias pon='predict-on'
alias poff='predict-off'
alias p='ping -c 4'

alias cp='nocorrect cp -irp'
alias refe='nocorrect refe'

# git
alias g='git'
alias gi='git'
alias gs='git status -s -b'
alias gst='git status -s -b'
alias gst="git log --date=short --max-count=1 --pretty=format:'%Cgreen%h %cd %Cblue%cn%x09%Creset%s' | tail -1 && echo '' && git status -s -b"
alias gc='git commit'
alias gci='git commit -a'
alias '偽ｔ'=git
compdef g=git

alias -g BN='`git symbolic-ref --short HEAD`'

alias java='nocorrect java'
alias cp='nocorrect cp -irp'
alias erl='nocorrect erl'
alias sbcl='nocorrect sbcl'
alias gosh='nocorrect gosh'
alias node='nocorrect node'
alias perl6='nocorrect perl6'

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,rar}=x

alias ydl='youtube-dl -f mp4 $@'
alias ydlx='youtube-dl -x --audio-format mp3 $@'

