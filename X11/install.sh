#!/bin/sh

mkdir -p $HOME/.fonts

cp "PowerlineSymbols.otf" $HOME/.fonts/
fc-cache -fv $HOME/.fonts
