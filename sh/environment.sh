if [ -x "$(which mlclient)" ]
then
    export TERMINAL="$(which mlclient)"
elif [ -x "$(which urxvtc)" ]
then
    export TERMINAL="$(which urxvtc)"
elif [ -x "$(which terminology)" ]
then
    export TERMINAL="$(which terminology)"
elif [-x "$(which x-terminal-emulator)" ]
then
    export TERMINAL="$(which x-terminal-emulator)"
elif [ -x "$(which uxterm)" ]
then
    export TERMINAL="$(which uxterm)"
else
    export TERMINAL="$(which xterm)"
fi

export PAGER="$(which less)"
export EDITOR="$(which vim)"
export PATH="$HOME/.local/bin:$HOME/.secondlife-install:$HOME/.cargo/bin:$PATH"
export SHELL="$(which zsh)"
export GPG_TTY="$(tty)"

