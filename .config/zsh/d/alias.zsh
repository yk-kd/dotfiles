# ls

if type eza &>/dev/null; then
  alias ls="eza"
fi
compdef ls=eza
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l --time-style iso --no-user"
alias lla="ll -a"

if type gomi &>/dev/null; then
  alias rm="gomi"
fi

alias cat="bat -p"

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
# tmux
#alias tmux='tmux attach || tmux new-session'
alias tm='tmux'
alias tma='tmux attach'
alias tma0='tmux attach -t 0'
alias tma1='tmux attach -t 1'
alias tma2='tmux attach -t 2'
alias tml='tmux list-sessions'

alias p='ping -c 4'

alias cp='nocorrect cp -irp'
alias refe='nocorrect refe'

# git
alias g='git'
alias gs='git status -s -b'
alias gst='git status -s -b'
alias gst="git log --date=short --max-count=1 --pretty=format:'%Cgreen%h %cd %Cblue%cn%x09%Creset%s' | tail -1 && echo '' && git status -s -b"
alias gc='git commit'
alias gci='git commit -a'
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


function switch_aws() {
    config=$(aws configure list-profiles | sort | fzf)
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    export AWS_DEFAULT_PROFILE=$config
}

alias awsp=switch_aws
assume_role() {
  # すべての AWS プロファイルを取得
  profiles=($(awk '/^\[profile / {gsub(/\[profile |]/,""); print $0}' ~/.aws/config))

  if [[ -z "$profiles" ]]; then
    echo "No AWS profiles found in ~/.aws/config"
    return 1
  fi

  # fzfでプロファイルを選択
  selected_profile=$(printf '%s\n' "${profiles[@]}" | fzf --prompt="Select AWS Profile: ")

  if [[ -z "$selected_profile" ]]; then
    echo "No profile selected"
    return 1
  fi

  # MFAデバイスのARNを取得
  mfa_serial=$(aws configure get mfa_serial --profile "$selected_profile")
  if [[ -z "$mfa_serial" ]]; then
    echo "MFA device ARN not configured for profile $selected_profile"
    return 1
  fi

  # MFAコードの入力
  mfa_token=$(gum input --placeholder "MFA Token")
  if [[ -z "$mfa_token" ]]; then
    echo "MFA token not provided"
    return 1
  fi

  # assume-role 実行
  role_arn=$(aws configure get role_arn --profile "$selected_profile")
  source_profile=$(aws configure get source_profile --profile "$selected_profile")

  if [[ -z "$role_arn" || -z "$source_profile" ]]; then
    echo "role_arn or source_profile not configured in profile $selected_profile"
    return 1
  fi

  session_name="assumed-role-$(date +%s)"

  creds=$(aws sts assume-role \
    --profile "$source_profile" \
    --role-arn "$role_arn" \
    --role-session-name "$session_name" \
    --serial-number "$mfa_serial" \
    --token-code "$mfa_token" \
    --output json)

  if [[ $? -ne 0 ]]; then
    echo "Failed to assume role"
    return 1
  fi

  unset AWS_DEFAULT_PROFILE
  export AWS_ACCESS_KEY_ID=$(echo "$creds" | jq -r .Credentials.AccessKeyId)
  export AWS_SECRET_ACCESS_KEY=$(echo "$creds" | jq -r .Credentials.SecretAccessKey)
  export AWS_SESSION_TOKEN=$(echo "$creds" | jq -r .Credentials.SessionToken)

  echo "Successfully assumed role for profile: $selected_profile"
}
