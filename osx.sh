#!/bin/bash -e

exists() {
    which "$1" > /dev/null
}


if ! exists brew; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

if [ -f "/usr/bin/git" ]; then
    sudo mv /usr/bin/git /usr/bin/git_old
fi

if ! exists git; then
    brew install git
fi

brew install tig
git config --global user.name "ankit rokde"
git config --global user.email ankitrokdeonsns@gmail.com
git config --global color.ui true
git config --global core.editor "/usr/bin/vim"

echo "export PATH=/usr/local/bin:$PATH" >> $HOME/aliases

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

SOLARIZED_TERM_DIR=$PACKAGES_DIR/solarized
if [ ! -d "$SOLARIZED_TERM_DIR" ]; then
    cd $HOME
    mkdir -p $SOLARIZED_TERM_DIR
    cd $SOLARIZED_TERM_DIR
    curl -O "https://raw.github.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Light.itermcolors"
    curl -O "https://raw.github.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors"
fi

if ! exists pip; then
    sudo easy_install pip
fi

if ! exists nvpy; then
    sudo pip install nvpy
fi
NVPY_CFG_FILE=$HOME/.nvpy.cfg
if [ ! -f $NVPY_CFG_FILE ]; then
    echo "[nvpy]" > $NVPY_CFG_FILE
    echo "sn_username = " >> $NVPY_CFG_FILE
    echo "sn_password = " >> $NVPY_CFG_FILE
fi

if ! exists ag; then
    brew install ag
fi
