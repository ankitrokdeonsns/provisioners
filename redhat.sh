#!/bin/bash -e

exists() {
    which "$1" > /dev/null
}

if ! exists git; then
    yum install -y git
fi

yum install tig vim
git config --global user.name "ankit rokde"
git config --global user.email ankitrokdeonsns@gmail.com
git config --global color.ui true
git config --global core.editor "/usr/bin/vim"

DOTFILES_DIR=$HOME/dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    cd $HOME
	git clone https://github.com/ankitrokdeonsns/dotfiles.git
    $DOTFILES_DIR/script.sh
    cd $DOTFILES_DIR
    git submodule update --init
fi

PROVISIONERS_DIR=$HOME/provisioners
if [ ! -d "$PROVISIONERS_DIR" ]; then
    cd $HOME
	git clone https://github.com/ankitrokdeonsns/provisioners.git
fi

PACKAGES_DIR=$HOME/packages
mkdir -p $PACKAGES_DIR
mkdir -p $HOME/work $HOME/tmp

SOLARIZED_TERM_DIR=$PACKAGES_DIR/xfce4-terminal-colors-solarized
if [ ! -d "$SOLARIZED_TERM_DIR" ]; then
    cd $PACKAGES_DIR
    git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git
fi
XFCE_TERM_CONF_DIR=$HOME/.config/xfce4/terminal
mkdir -p $XFCE_TERM_CONF_DIR
cp $SOLARIZED_TERM_DIR/light/terminalrc $XFCE_TERM_CONF_DIR/terminalrc

sudo yum install -y synapse firefox system-config-date okular
sudo yum localinstall --nogpgcheck -y http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo yum install -y vlc
sudo rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
sudo yum check-update
sudo yum install -y flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl
