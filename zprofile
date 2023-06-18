# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi
if [ -d "$HOME/go/bin" ] ; then
    PATH="$HOME/go/bin:$PATH"
fi
if [ -d "$HOME/.config/node_modules/.bin" ] ; then
    PATH="$HOME/.config/node_modules/.bin:$PATH"
fi
if [ -d "$HOME/.local/share/gem/ruby/3.0.0/bin" ] ; then
    PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
fi

export PATH="/mnt/c/zoo:$PATH"


	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_DATA_HOME=$HOME/.local/share
	export XDG_STATE_HOME=$HOME/.local/state

# vim:ft=zsh:nowrap
