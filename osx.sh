#!/bin/bash -e

exists() {
    which "$1" > /dev/null
}


if ! exists brew; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

if [ -f "/usr/bin/git" ]; then
    mv /usr/bin/git /usr/bin/git_old
fi

if ! exists git; then
    brew install git
fi

brew install tig
git config --global user.name "ankit rokde"
git config --global user.email ankitrokdeonsns@gmail.com
git config --global color.ui true
git config --global core.editor "/usr/bin/vim"

cd $HOME
DOTFILES_DIR=$HOME/dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
	git clone https://github.com/ankitrokdeonsns/dotfiles.git
    $DOTFILES_DIR/script.sh
    cd $DOTFILES_DIR
    git submodule update --init
fi

cd $HOME
PROVISIONERS_DIR=$HOME/provisioners
if [ ! -d "$PROVISIONERS_DIR" ]; then
	git clone https://github.com/ankitrokdeonsns/provisioners.git
fi

PACKAGES_DIR=$HOME/packages
mkdir -p $PACKAGES_DIR
mkdir -p $HOME/work $HOME/tmp
