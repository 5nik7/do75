#!/bin/bash
# {{{ main

main() {
  # Save current working directory.
  cwd=$(pwd)

  # Source configuration files and clean when necessary.
  sourceFiles

  # Install packages.
  installPacmanPackages

  # Make source directory.
  mksrc
  installYayPackages
  installRust
  buildNeovim
  addProgramsNeoVimInterfacesWith

  # Setup symlinks.
  createSymLinks

  # Final personalization
  zshshell

}

# -------------------------------------------------------------------------- }}}
# {{{ Source all configuration files
sourceFiles() {
  missingFile=0

  files=(packages)
  for f in ${files[@]}
  do
    source $f
  done

  [[ $missingFile == 1 ]] && say 'Missing file(s) program exiting.' && exit

}

# -------------------------------------------------------------------------- }}}
# {{{ Update OS Keys

# updateOSKeys() {
#   if [[ $osUpdateKeysFlag == 1 ]]; then
#     say 'Update keys'
#     sudo pacman-key --init
#     sudo pacman-key --populate
#     sudo pacman-key --refresh-keys
#     sudo pacman -Sy archlinux-keyring --noconfirm
#   fi
# }


# -------------------------------------------------------------------------- }}}
# {{{ Update OS

# updateOS() {
#   if [[ $osUpdateFlag == 1 ]]; then
#     say 'Updating System'
#     sudo pacman -Syyu --noconfirm
#   fi
# }

# -------------------------------------------------------------------------- }}}
# {{{ Install pacman packages.

installPacmanPackages() {
  say 'Installing pacman packages.'
  sudo pacman -Syyu --noconfirm ${pacman_packages[@]}
}

# -------------------------------------------------------------------------- }}}
# {{{ Source all configuration files

mksrc() {
    say 'Making source directory.'
    mkdir -v $HOME/source
}

# -------------------------------------------------------------------------- }}}
# {{{ Install yay packages.

installYayPackages() {
    src=https://aur.archlinux.org/yay.git
    dst=$HOME/source/yay
    if [[ -d ${dst} ]]; then
        say 'Installing yay packages.'
        yay -Syu --noconfirm ${yay_packages[@]}
    else
        say 'Building yay.'
        git clone ${src} ${dst}
        cd ${dst}
        makepkg -si
        cd -
        say 'Installing yay packages.'
        yay -Syu --noconfirm ${yay_packages[@]}
    fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Install Rust

installRust() {
# Install Rust
  curl --proto '=https' --tlsv1.2 -sFf https://sh.rustup.rs | sh
  echo 'Rust installed.'
}

# -------------------------------------------------------------------------- }}}
# {{{ Build Neovim

buildNeovim() {
    # say 'Acquire neovim dependencies.'
    # sudo pacman -Syu --noconfirm \
    #   base-devel \
    #   cmake \
    #   ninja \
    #   tree-sitter \
    #   unzip

    say 'Building neovim.'
    src=https://github.com/neovim/neovim
    dst=$HOME/source/neovim

    if [[ -d ${dst} ]]; then
      echo 'Update neovim sources.'
      cd ${dst}
      git pull
    else
      echo 'Clone neovim sources.'
      git clone $src $dst
    fi

    echo 'Build neovim.'
    cd ${dst}
    sudo make CMANE_BUILD=RelWithDebInfo install
    cd $HOME
}

# -------------------------------------------------------------------------- }}}
# {{{ Add programs Neovim interfaces with.

addProgramsNeoVimInterfacesWith() {
    say 'Add programs Neovim interfaces with.'
    gem install neovim
    npm install --global neovim
    python -m pip install --user --upgrade pynvim
}

# -------------------------------------------------------------------------- }}}
# {{{ deleteSymLinks

# deleteSymLinks() {
#   if [[ $symlinksFlag == 1 ]]; then
#     echo "Deleting symbolic links."
#     # Symlinks at .config
# #    rm -rfv ~/.config/Thunar
#     rm -rfv ~/.config/nvim
#     rm -rfv ~/.config/ranger
#     rm -rfv ~/.config/starship
#     rm -rfv ~/.config/tmux
#     rm -rfv ~/.config/zsh
#     rm -fsv ~/.scripts
#     rm -rfv ~/.gitconfig
#     rm -fsv ~/.tmux.conf
#     rm -rfv ~/.zshenv
#   fi
# }

# -------------------------------------------------------------------------- }}}
# {{{ createSymLinks

createSymLinks() {
    say 'Creating symbolic links.'
    # Symlinks at .config
    ln -fsv ~/git/do75/config/btop                         ~/.config/btop
    ln -fsv ~/git/do75/config/nvim	                       ~/.config/nvim
    ln -fsv ~/git/do75/config/ranger                       ~/.config/ranger
    ln -fsv ~/git/do75/config/starship                     ~/.config/starship
    ln -fsv ~/git/do75/config/tmux                         ~/.config/tmux
    ln -fsv ~/git/do75/config/wezterm                      ~/.config/wezterm
    ln -fsv ~/git/do75/config/zsh                          ~/.config/zsh
    ln -fsv ~/git/do75/scripts                             ~/.scripts
    ln -fsv ~/git/do75/wallpapers                          ~/.wallpapers
    ln -fsv ~/git/do75/gitconfig                           ~/.gitconfig
    ln -fsv ~/git/do75/tmux.conf                           ~/.tmux.conf
    ln -fsv ~/git/do75/zshenv                              ~/.zshenv

}

# -------------------------------------------------------------------------- }}}
# {{{ Set shell to zsh

zshshell() {
  sudo chsh -s /bin/zsh $USER
}

# -------------------------------------------------------------------------- }}}
# {{{ Echo something with a separator line.

say() {
  echo
  echo '**********************'
  echo $@
}

# -------------------------------------------------------------------------- }}}
# {{{ Echo a command and then execute it.

sayAndDo() {
  say $@
  $@
  echo
}

# -------------------------------------------------------------------------- }}}
# {{{ The stage is set ... start the show!!!

main $@

# -------------------------------------------------------------------------- }}}
