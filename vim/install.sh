#!/bin/sh

echo "Copying CoolBasic syntax..."
mkdir -p $HOME/.vim/syntax
cp syntax/coolbasic.vim $HOME/.vim/syntax

echo "Cloning Vundle..."
mkdir -p $HOME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
echo "Installing..."

# Run the install script and once finished, quit
vim -c 'VundleInstall' -c 'qa'

# Update plugins if they've changed, since I think install doesn't do this
vim -c 'VundleUpdate' -c 'qa'

echo "Building YCM"
cd "$HOME/.vim/bundle/YouCompleteMe" &&\
echo $PWD
if [ "x$VIM_DEPLOY_SYSTEM_CLANG" != "x" ]
then
    python3 ./install.py --system-libclang --all
else
    python3 ./install.py --all
fi
