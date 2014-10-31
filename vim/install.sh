#!/bin/sh

echo "Copying CoolBasic syntax..."
mkdir -p $HOME/.vim/syntax
cp syntax/coolbasic.vim $HOME/.vim/syntax

echo "Cloning Vundle..."
mkdir -p $HOME/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
echo "Installing..."
# Run the install script and once finished, quit
vim -c 'VundleInstall' -c 'qa'

# For YCM
cd $HOME/.vim/bundle/YouCompleteMe &&\
echo $PWD &&\
sh ./install.sh --clang-completer --omnisharp-completer
