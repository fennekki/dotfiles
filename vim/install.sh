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

cp ycm_extra_conf.py $HOME/.vim/ycm_extra_conf.py
cp vimoutlinerrc $HOME/.vim/vimoutlinerrc

# For YCM
if [ ! -e $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]
then
    cd "$HOME/.vim/bundle/YouCompleteMe" &&\
    echo $PWD
    if [ "x$VIM_DEPLOY_SYSTEM_CLANG" != "x" ]
    then
        python2 ./install.py --system-libclang --all
    else
        python2 ./install.py --all
    fi
fi

# Update plugins if they've changed
vim -c 'VundleUpdate' -c 'qa'
