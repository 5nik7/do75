function cd() {
    builtin cd "$@" && clear && exa -laH --icons --group-directories-first
}
function cdls() {
    \cd "$@" && clear && exa -laH --icons --group-directories-first
}
alias cd="cd"
alias cdls="cdls"

alias ..='cd ..'
alias ...='cd ...'

alias tm='tmux'
alias tls='tmux ls'
alias tks='tmux kill-session'

alias l='exa -laH --icons --group-directories-first'
alias lt='exa -T --icons'
alias v='nvim'
alias vim='nvim'
alias c='clear'
alias d='nnn -H'

alias dots='cd $DOTFILES' 
