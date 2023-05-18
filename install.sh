#!/bin/bash

main() {

  sourceFiles
  updateOS
  installPacmanPackages
  mksrc
  installYayPackages
  installtpm
  installRust
  buildNeovim
  addProgramsNeoVimInterfacesWith
  createSymLinks
  zshshell

}

sourceFiles() {
  missingFile=0

  files=(packages)
  for f in ${files[@]}
  do
    source $f
  done

  [[ $missingFile == 1 ]] && say 'Missing file(s) program exiting.' && exit

}

# updateOSKeys() {
#   if [[ $osUpdateKeysFlag == 1 ]]; then
#     say 'Update keys'
#     sudo pacman-key --init
#     sudo pacman-key --populate
#     sudo pacman-key --refresh-keys
#     sudo pacman -Sy archlinux-keyring --noconfirm
#   fi
# }

updateOS() {
  say 'Updating System'
  sudo pacman -Syyuu --noconfirm
}

installPacmanPackages() {
  say 'Installing pacman packages.'
  sudo pacman -Syyuu --noconfirm ${pacman_packages[@]}
}


mksrc() {
    say 'Making source directory.'
    mkdir -v $HOME/source
}

installYayPackages() {
    src=https://aur.archlinux.org/yay-bin.git
    dst=$HOME/source/yay-bin
    if [[ -d ${dst} ]]; then
        say 'Installing yay packages.'
        yay -Syu --noconfirm ${yay_packages[@]}
    else
        say 'Building yay.'
        git clone ${src} ${dst}
        cd ${dst}
        makepkg -si
        cd $HOME
        say 'Installing yay packages.'
        yay -Syu --noconfirm ${yay_packages[@]}
    fi
}

installtpm() {
# Install tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo 'tpm installed.'
}

installRust() {
  curl --proto '=https' --tlsv1.2 -sFf https://sh.rustup.rs | sh
  echo 'Rust installed.'
}

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

addProgramsNeoVimInterfacesWith() {
    say 'Add programs Neovim interfaces with.'
    gem install neovim
    npm install neovim
    python -m pip install --user --upgrade pynvim
}

# deleteSymLinks() {
#   if [[ $symlinksFlag == 1 ]]; then
#     echo "Deleting symbolic links."
#     # Symlinks at .config
#     rm -rfv ~/.config/Thunar
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

createSymLinks() {
    say 'Creating symbolic links.'
    # Symlinks at .config
    ln -fsv $HOME/git/do75/config/btop                         $HOME/.config/btop
    ln -fsv $HOME/git/do75/config/nvim	                       $HOME/.config/nvim
    ln -fsv $HOME/git/do75/config/ranger                       $HOME/.config/ranger
    ln -fsv $HOME/git/do75/config/starship                     $HOME/.config/starship
    ln -fsv $HOME/git/do75/config/wezterm                      $HOME/.config/wezterm
    ln -fsv $HOME/git/do75/config/zsh                          $HOME/.config/zsh
    ln -fsv $HOME/git/do75/scripts                             $HOME/.scripts
    ln -fsv $HOME/git/do75/wallpapers                          $HOME/.wallpapers
    ln -fsv $HOME/git/do75/gitconfig                           $HOME/.gitconfig
    ln -fsv $HOME/git/do75/tmux.conf                           $HOME/.tmux.conf
    ln -fsv $HOME/git/do75/zshenv                              $HOME/.zshenv

}

zshshell() {
  sudo chsh -s /bin/zsh $USER
}

say() {
  echo
  echo '**********************'
  echo $@
}

sayAndDo() {
  say $@
  $@
  echo
}

main $@
