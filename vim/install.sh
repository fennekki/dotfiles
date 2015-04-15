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

cp ycm_extra_conf.py $HOME/.vim/ycm_extra_conf.py
cp vimoutlinerrc $HOME/.vim/vimoutlinerrc

# For YCM
if [ ! -e $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]
then
    cd "$HOME/.vim/bundle/YouCompleteMe" &&\
    echo $PWD
    if [ "x$VIM_DEPLOY_NO_SYSTEM_CLANG" != "x" ]
    then
        sh ./install.sh --clang-completer --omnisharp-completer
    else
        sh ./install.sh --clang-completer --system-libclang --omnisharp-completer
    fi
fi

# Update plugins if they've changed
vim -c 'VundleUpdate' -c 'qa'
