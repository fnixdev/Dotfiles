#!/bin/bash
# 
# == install dot script by fnix

readonly PKGS_PACMAN=(
  i3 i3lock i3-gaps
  netctl dialog dhcpcd wireless_tools
  rofi
  picom
  kitty
  zsh
  curl
  unzip
  feh
  thunar
  xdg-user-dirs xdg-user-dirs-gtk xdg-utils
  notepadqq
  lxappearance
  scrot
  git
  lm_sensors
  alsa-utils alsa-lib
  xorg-server xorg-xprop xorg-xinit xorg-xrandr arandr xorg-xfd
  ttf-inconsolata ttf-fantasque-sans-mono
  bluez bluez-utils
  python-pip
)

readonly PKGS_AUR=(
  visual-studio-code-bin
  google-chrome
)

function install_pkgs_pacman(){
  for i in "${PKGS_PACMAN[@]}"; do
    sudo pacman -S ${i} --needed --noconfirm
  done
}

function install_pkgs_aur(){
  for i in "${PKGS_AUR[@]}"; do
    yay -S ${i} --needed --noconfirm
  done
}

function install_yay(){
  if ! type -p yay > /dev/null
  then
    clear
    echo -e "[★] - Instalando yay\n"
    sleep 3
    cd $HOME
    sudo rm -rf $HOME/yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    sudo rm -rf $HOME/yay
  fi
}

function install_dotfiles(){
  clear
  echo -e "[★] - Preparando Dotfiles...\n"
  sleep 3
  cd $HOME
  git clone https://github.com/fnixdev/Dotfiles
  xdg-user-dirs-update
  xdg-user-dirs-gtk-update
  cd $HOME/Dotfiles/

  echo -e "\n[★] - Instalando i3gaps config\n"
  sleep 3
  sudo rm -rf $HOME/.config/i3
  mkdir -p $HOME/.config/i3
  cp -r assets/.config/i3 $HOME/.config

  echo -e "\n[★] - Instalando Polybar config\n"
  sleep 3
  sudo rm -rf $HOME/.config/polybar
  mkdir -p $HOME/.config/polybar
  cp -r assets/.config/polybar $HOME/.config

  echo -e "\n[★] - Instalando Picom config\n"
  sleep 3
  sudo rm -rf $HOME/.config/picom
  mkdir -p $HOME/.config/picom
  cp -r assets/.config/picom $HOME/.config

  echo -e "\n[★] - Instalando Rofi config\n"
  sleep 3
  sudo rm -rf $HOME/.config/rofi
  mkdir -p $HOME/.config/rofi
  cp -r assets/.config/rofi $HOME/.config

  echo -e "\n[★] - Instalando Kitty config\n"
  sleep 3
  sudo rm -rf $HOME/.config/kitty
  mkdir -p $HOME/.config/kitty
  cp -r assets/.config/kitty $HOME/.config

  echo -e "\n[★] - Instalando .xinitrc config\n"
  sleep 3
  sudo rm -rf $HOME/.xinitrc
  cp assets/.xinitrc $HOME/.xinitrc

  echo -e "\n[★] - Movendo scripts\n"
  sleep 3
  sudo rm -rf $HOME/scripts
  cp -r scripts $HOME

  echo -e "\n[★] - Configurando Teclado ABNT2\n"
  sleep 3
  sudo rm -rf /etc/X11/xorg.conf.d
  sudo mkdir -p /etc/X11/xorg.conf.d
  sudo cp etc/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d
}

function config_setup(){
  clear
  sleep 3
  amixer set 'Master' 100% unmute
  sudo alsactl store

  echo -e "\n[★] - Configurando Pacman\n"
  sleep 3
  sudo sed -i '37iILoveCandy' /etc/pacman.conf
  sudo sed -i '/Color/,+1 s/^#//' /etc/pacman.conf

  echo -e "\n[★] - Configurando Wallpapers\n"
  sleep 3
  rm -rf $HOME/Wallpapers
  cp -r $HOME/Dotfiles/assets/Wallpapers $HOME
  feh --bg-max --bg-fill --no-fehbg --randomize $HOME/Wallpapers/*
}

function oh_my_zsh(){
  clear
  echo -e "[★] - Instalando Oh-My-Zsh\n"
  sleep 3
  cd $HOME
  sudo rm -rf $HOME/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  echo -e "[★] - Copiando zsh config\n"
  cp $HOME/Dotfiles/assets/.zshrc $HOME/.zshrc
}

function config_system(){
  clear
  echo -e "[★] - Configurando o Sistema\n"
  sleep 3
  cd $HOME
  read -p "Git email: " gitEmail
  git config --global user.email ${gitEmail}
  read -p "Git name: " gitName
  git config --global user.name ${gitName}

  echo -e "[★] - Configurando o LastFM Now Playing\n"
  sleep 3
  read -p "Digite seu username LastFM: " userLast
  sed -i "s/lastuser/$userLast/g" $HOME/.config/polybar/scripts/lastfm.py
  read -p "Digite sua LastFM ApiKey: " keyLast
  sed -i "s/lastkey/$keyLast/g" $HOME/.config/polybar/scripts/lastfm.py

  echo -e "[★] - Configurando o Modulos Python\n"
  sleep 3
  pip install -U autopep8
  pip install apscheduler
}

install_pkgs_pacman
install_yay
install_pkgs_aur
install_dotfiles
config_setup
config_system
oh_my_zsh
