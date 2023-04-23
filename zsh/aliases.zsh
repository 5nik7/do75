alias pac="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias l='exa -ahlHB --icons --no-user --no-time --octal-permissions --group-directories-first --no-filesize'
alias lt='exa -T --icons'
alias v='nvim'
alias vim='nvim'
alias c='clear'
alias d='nnn -H'
alias neofetch="neofetch --w3m --size 50% --distro_shorthand on --source ~/.config/i3/background.png"


alias dots='cd ~/do75'

alias imgo='python ~/Downloads/ImageGoNord-cli/src/cli.py'


alias ff='fzf --color='fg:7,fg+:15,border:8' --height 50% --layout reverse --info inline --border=sharp --preview "bat -p --color=always --theme=base16 {}"'
