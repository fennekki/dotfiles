compile_config () {
    cat "$HOME/.i3/config.d/"*

    if [ -f "$HOME/.i3.local" ]
    then
        cat "$HOME/.i3.local"
    fi
}

mkdir -p "$HOME/.config/i3"
compile_config > "$HOME/.config/i3/config"
