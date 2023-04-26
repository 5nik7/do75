export DOTFILES="$HOME/do75"

export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CACHE_HOME=${HOME}/.cache

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
export GTK_THEME=Breeze-Dark
export LIBGL_ALWAYS_INDIRECT=1 #GWSL
export GDK_SCALE=2 #GWSL

export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim +Man!'

export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER='Chromium'


export LANG=en_US.UTF-8


export PATH=$HOME/bin:/usr/local/bin:$PATH

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export STARSHIP_CACHE=~/.starship/cache
export STARSHIP_CONFIG=~/.config/starship.toml

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
