# Unset the default fish greeting text which messes up Zellij
set fish_greeting

# Check if we're in an interactive shell
if status is-interactive

    # At this point, specify the Zellij config dir, so we can launch it manually if we want to
    export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij

    # Check if our Terminal emulator is Ghostty
    if [ "$TERM" = "xterm-ghostty" ]
        # Launch zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end

# Add dotfiles scripts to PATH
fish_add_path $HOME/.dotfiles/scripts

alias claude="/Users/xavier/.claude/local/claude"
