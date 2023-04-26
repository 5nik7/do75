function cd() {
    builtin cd "$@" && clear && exa -laHF --icons --no-time --no-user --group-directories-first
}
function cdls() {
    \cd "$@" && clear && exa -laHF --icons --no-time -no-user --group-directories-first
}
alias cdls="cdls"

# use exa if available
if [[ -x "$(command -v exa)" ]]; then
  alias ll="exa -HF --icons --git --long --no-user --no-time --group-directories-first"
  alias l="exa -HF --icons --git --all --long --no-time --no-user --group-directories-first"
else
  alias l="ls -lah ${colorflag}"
  alias ll="ls -lFh ${colorflag}"
fi
alias la="ls -AF ${colorflag}"
alias lld="ls -l | grep ^d"
alias rmf="rm -rf"

# alias l='exa -laH --icons --group-directories-first'

alias ..='cd ..'
alias ...='cd ...'

alias t='tmux'
alias tls='tmux ls'
alias tks='tmux kill-session'

alias cp='cp -rv'
alias mv='mv -v'
alias rmf='rm -rfv'
alias lnf='ln -sfv'
alias mkdir='mkdir -v'

alias ff='fzf --color='fg:7,fg+:15,border:8' --height 50% --layout reverse --info inline --border=sharp --preview "bat -p --color=always --theme=base16 {}"'

alias lpath='echo $PATH | tr ":" "\n"' # list the PATH separated by new lines
alias lt='exa -T --icons'
alias v='nvim'
alias vim='nvim'
alias c='clear'
alias d='ranger'
alias e='ranger'
alias q='exit'

alias cat='bat'
alias g='git'
alias py='python'

alias reload='RELOAD=1 source ~/.zshrc'
alias dots='cd $DOTFILES'
