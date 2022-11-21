HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000

# Command substitution in prompt
setopt PROMPT_SUBST

# Append each line to history file as it's typed
setopt INC_APPEND_HISTORY
# Share history between instances
setopt SHARE_HISTORY
# Store more than just command!
setopt EXTENDED_HISTORY
# Ignore same command repeated multiple times
setopt HIST_IGNORE_DUPS
# Don't store function definitions
setopt HIST_NO_FUNCTIONS

# Don't do the weird stream direction shit
setopt NO_MULTIOS

# Don't enable `r`!!!
disable r
