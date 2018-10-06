autoload -U colors && colors

if [ "$_DOTFILES_RPROMPT_ALREADY_SET" != "yes" ]
then

    PROMPT='%{$fg_no_bold[green]%}%2~ %{$fg_bold[blue]%}%#%{%b%} '

    # RPROMPT should be set by plugins

    # Battery status for laptop
    if [[ -a /sys/class/power_supply/BAT0 ]]
    then
        RPROMPT="$RPROMPT "'[`cat /sys/class/power_supply/BAT0/status` `cat /sys/class/power_supply/BAT0/capacity`%%]'
    fi
    if [[ -a /sys/class/power_supply/BAT1 ]]
    then
        RPROMPT="$RPROMPT "'[`cat /sys/class/power_supply/BAT1/status` `cat /sys/class/power_supply/BAT1/capacity`%%]'
    fi

    RPROMPT="$RPROMPT "'[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]'

    export _DOTFILES_RPROMPT_ALREADY_SET="yes"
fi
