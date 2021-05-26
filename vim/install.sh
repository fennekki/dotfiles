#!/bin/sh

echo "Copying CoolBasic syntax..."
mkdir -p $HOME/.vim/syntax
cp syntax/coolbasic.vim $HOME/.vim/syntax

echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Update plugins"
vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'qa' && (
    if [ -d ~/.vim/bundle ]
    then
        echo "Removing old Vundle plugins"
        rm -rf ~/.vim/bundle
    fi
)
