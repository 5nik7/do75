#!/bin/bash
# {{{ main

main() {
  # Save current working directory.
  cwd=$(pwd)

  # Update operating system and keys.
  updateOS

  # Install packages.
  installPacmanPackages
  installParuPackages
  installYayPackages
  installPipPackages

  # Update mirrors.
  updateMirrorList

  # Install programming languages.
  installRuby
  installRubyGems
  installRust

  # Setup symlinks.
  deleteSymLinks
  createSymLinks

  # Build applications from source code.
  buildNeovim
  addProgramsNeoVimInterfacesWith

  # Install editors and terminal multiplexers.
  loadTmuxPlugins

  # Final personalization

   # [[ -f $HOME/.zshrc ]] && source $HOME/.zshrc 

 }

# -------------------------------------------------------------------------- }}}
# {{{ Update OS

updateOS() {
  [[ $osUpdateFlag == 1 ]] && sayAndDo 'sudo pacman -Syyu --noconfirm'
}


# -------------------------------------------------------------------------- }}}
# {{{ Install pacman packages.

installPacmanPackages() {
  if [[ $pacmanPackagesFlag == 1 ]]; then
    say 'Installing pacman packages.'
    sudo pacman -Syyu --noconfirm ${pacman_packages[@]}
  fi
}

# -------------------------------------------------------------------------- }}}

# {{{ Install paru packages.

installParuPackages() {
  if [[ $paruPackagesFlag == 1 ]]; then
    say 'Installing paru packages.'
    
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    
    paru -Syu --noconfirm ${yay_packages[@]}
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Install yay packages.

installYayPackages() {
  if [[ $yayPackagesFlag == 1 ]]; then
    say 'Installing yay packages.'

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..

    yay -Syu --noconfirm ${yay_packages[@]}
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Install pip packages.

installPipPackages() {
  if [[ $pipPackagesFlag == 1 ]]; then
    say 'Installing pip packages.'
    pip install ${pip_packages[@]}
  fi
}




# -------------------------------------------------------------------------- }}}
# {{{ deleteSymLinks

deleteSymLinks() {
  if [[ $symlinksFlag == 1 ]]; then
    echo "Deleting symbolic links."
    # Symlinks at .config
#    rm -rfv ~/.config/Thunar
    rm -rfv ~/.config/btop
    rm -rfv ~/.config/cava
    rm -rfv ~/.config/dunst
    rm -rfv ~/.config/hypr
    rm -rfv ~/.config/neofetch
    rm -rfv ~/.config/nvim
    rm -rfv ~/.config/pipewire
    rm -rfv ~/.config/ranger
    rm -rfv ~/.config/rofi
    rm -rfv ~/.config/starship
    rm -rfv ~/.config/swaylock
    rm -rfv ~/.config/tmux
    rm -rfv ~/.config/viewnior
    rm -rfv ~/.config/waybar
    rm -rfv ~/.config/wezterm
    rm -rfv ~/.config/wlogout
    rm -rfv ~/.config/zsh
    rm -fsv ~/.local/bin/wrappedhl
    rm -fsv ~/.scripts
    rm -fsv ~/.wallpapers
    rm -rfv ~/.gitconfig
    rm -fsv ~/.tmux.conf
    rm -rfv ~/.zshenv 
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ createSymLinks

createSymLinks() {
  if [[ $symlinksFlag == 1 ]]; then
    say 'Creating symbolic links.'
    # Symlinks at .config
    ln -fsv ~/do75/.config/btop                         ~/.config/btop
    ln -fsv ~/do75/.config/cava                         ~/.config/cava
    ln -fsv ~/do75/.config/dunst                        ~/.config/dunst
    ln -fsv ~/do75/.config/hypr                         ~/.config/hypr
    ln -fsv ~/do75/.config/neofetch                     ~/.config/neofetch
    ln -fsv ~/do75/.config/nvim	                        ~/.config/nvim
    ln -fsv ~/do75/.config/pipewire                     ~/.config/pipewire
    ln -fsv ~/do75/.config/ranger                       ~/.config/ranger
    ln -fsv ~/do75/.config/rofi                         ~/.config/rofi
    ln -fsv ~/do75/.config/starship                     ~/.config/starship
    ln -fsv ~/do75/.config/swaylock                     ~/.config/swaylock
    ln -fsv ~/do75/.config/tmux                         ~/.config/tmux
    ln -fsv ~/do75/.config/viewnior                     ~/.config/viewnior
    ln -fsv ~/do75/.config/waybar                       ~/.config/waybar
    ln -fsv ~/do75/.config/wezterm                      ~/.config/wezterm
    ln -fsv ~/do75/.config/wlogout                      ~/.config/wlogout
    ln -fsv ~/do75/.config/zsh                          ~/.config/zsh
    ln -fsv ~/do75/.local/bin/wrappedhl                 ~/.local/bin/wrappedhl
    ln -fsv ~/do75/.scripts                             ~/.scripts
    ln -fsv ~/do75/.wallpapers                          ~/.wallpapers
    ln -fsv ~/do75/.gitconfig                           ~/.gitconfig
    ln -fsv ~/do75/.tmux.conf                           ~/.tmux.conf
    ln -fsv ~/do75/.zshenv                              ~/.zshenv

    # Symlinks at $HOME
 fi
}

# -------------------------------------------------------------------------- }}}
# {{{ cloneTmuxPlugins

cloneTmuxPlugins () {
  if [[ $tmuxPluginsFlag == 1 ]]; then
    say 'Cloning TMUX plugins.'
    src=https://github.com/tmux-plugins/tpm.git
    dst=~/.config/tmux/plugins/tpm
    git clone  $src $dst
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Build Neovim

buildNeovim() {
  if [[ $neovimBuildFlag == 1 ]]; then
    say 'Acquire neovim dependencies.'
    sudo pacman -Syu --noconfirm \
      base-devel \
      cmake \
      ninja \
      tree-sitter \
      unzip

    say 'Building neovim.'
    src=https://github.com/neovim/neovim
    dst=$cloneRoot/neovim

    if [[ -d ${dst} ]]; then
      echo 'Update neovim sources.'
      cd ${dst}
      git pull
    else
      echo 'Clone neovim sources.'
      git clone  $src $dst
    fi

    echo 'Build neovim.'
    cd ${dst}
    sudo make CMANE_BUILD=RelWithDebInfo install

    echo
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Add programs Neovim interfaces with.

addProgramsNeoVimInterfacesWith() {
  if [[ $neovimBuildFlag == 1 ]]; then
    say 'Add programs Neovim interfaces with.'
    gem install neovim
    sudo npm install -g neovim
    yarn global add neovim
    paru -S --noconfirm python-pip
    python -m pip install --user --upgrade pynvim
  fi
}


# -------------------------------------------------------------------------- }}}
# {{{ Update mirror list with reflector

updateMirrorList () {
  if [[ $mirroirFlag == 1 ]]; then
    say 'Updating mirror list.'

    sudo reflector -c "United States" \
      -f 12 -l 10 -n 12 \
      --save /etc/pacman.d/mirrorlist
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Install Ruby

installRuby() {
  if [[ $rbenvFlag == 1 ]]; then

    say 'Installing ruby-build dependencies.'
    sudo pacman -Syu --noconfirm ${ruby_build_packages[@]}

    say 'Acquire Ruby dependencies.'
    paru -S --noconfirm \
      rbenv \
      ruby-build \

    say 'Build and install Ruby.'
    eval "$(rbenv init -)"
    rbenv install $rubyVersion
    rbenv global $rubyVersion

    echo 'Ruby installed.'
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Install Ruby Gems

installRubyGems() {
  if [[ $rbenvFlag == 1 ]]; then

    # Install Ruby Gems
    gem install \
      bundler \
      rake \
      rspec \
      neovim

    echo 'Ruby Gems installed.'
  fi
}

# -------------------------------------------------------------------------- }}}
# {{{ Install Rust

installRust() {
  if [[ $rustFlag == 1 ]]; then

    # Install Rust
    curl --proto '=https' --tlsv1.2 -sFf https://sh.rustup.rs | sh
    echo 'Rust installed.'
  fi
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
