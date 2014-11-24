#!/bin/sh

mkdir -p $HOME/.fonts
cp "Inconsolata-g for Powerline.otf" $HOME/.fonts/
cp "PowerlineSymbols.otf" $HOME/.fonts/
cp "ProggySquare-Powerline.ttf" $HOME/.fonts/
fc-cache -fv $HOME/.fonts
