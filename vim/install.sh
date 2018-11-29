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

cp ycm_extra_conf.py $HOME/.vim/ycm_extra_conf.py
cp vimoutlinerrc $HOME/.vim/vimoutlinerrc

echo "Bulding YCM"
echo "(Requires python2.7-dev and cmake!!)"
cd "$HOME/.vim/bundle/YouCompleteMe" &&\
echo $PWD
if [ "x$VIM_DEPLOY_SYSTEM_CLANG" != "x" ]
then
    python2 ./install.py --system-libclang --all
else
    python2 ./install.py --all
fi
