# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE=true
setopt NO_BEEP
# Uncomment one of the following lines to change the auto-upate behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 13

zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'

# fuzzy completion when mistype
bindkey "^Xa" _expand_alias
zstyle ':completion:*' completer _expand_alias _complete _match _approximate
zstyle ':completion:*' regular true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"                       # color output with LS_COLORS
zstyle ":fzf-tab:complete:cd:*" fzf-preview 'exa -1 --color=always $realpath' # Preview directories with exa
HIST_STAMPS="mm/dd/yyyy"

plugins=(
    git 
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    ripgrep
)

source $HOME/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.zsh

source $HOME/.oh-my-zsh/oh-my-zsh.sh

source $HOME/.aliases.zsh
source $HOME/.exports.zsh


if [ -d "$HOME/.bin" ]; then
	PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

eval "$(starship init zsh)"
