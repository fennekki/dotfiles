# vi mode
bindkey -v

# Because I don't need redisplay almost ever
# This is emacs-like but seems to be relatively standard?

bindkey "^R" history-incremental-search-backward
