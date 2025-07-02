#!/bin/zsh
# Fast Robbyrussell-style prompt
# Optimized for speed with minimal git operations

# Colors
autoload -U colors && colors

# Git info cache variables
typeset -g _git_branch_cache=""
typeset -g _git_dirty_cache=""
typeset -g _git_cache_pwd=""
typeset -g _git_cache_time=0

# Fast git branch detection
git_prompt_info() {
    local current_pwd="$PWD"
    local current_time=$(date +%s)

    # Cache for 5 seconds to avoid repeated git calls
    if [[ "$current_pwd" == "$_git_cache_pwd" ]] && (( current_time - _git_cache_time < 5 )); then
        echo "$_git_branch_cache$_git_dirty_cache"
        return
    fi

    # Quick check if we're in a git repo
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        _git_branch_cache=""
        _git_dirty_cache=""
        _git_cache_pwd="$current_pwd"
        _git_cache_time="$current_time"
        return
    fi

    # Get branch name quickly
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

    if [[ -n "$branch" ]]; then
        _git_branch_cache=" %{$fg[blue]%}git:(%{$fg[red]%}$branch%{$fg[blue]%})"

        # Check if dirty (in background to avoid blocking)
        {
            if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
                _git_dirty_cache="%{$fg[yellow]%}✗%{$reset_color%}"
            else
                _git_dirty_cache=""
            fi
        } &!

    else
        _git_branch_cache=""
        _git_dirty_cache=""
    fi

    _git_cache_pwd="$current_pwd"
    _git_cache_time="$current_time"

    echo "$_git_branch_cache$_git_dirty_cache"
}

# Fast directory shortening
short_pwd() {
    local pwd_path="$PWD"

    # Replace home with ~
    pwd_path="${pwd_path/#$HOME/~}"

    # If path is longer than 40 characters, shorten it
    if [[ ${#pwd_path} -gt 40 ]]; then
        echo "...${pwd_path: -37}"
    else
        echo "$pwd_path"
    fi
}

# Main prompt function
robbyrussell_prompt() {
    local prompt_char="➜"
    local user_host=""

    # Only show user@host if we're remote or root
    if [[ -n "$SSH_CONNECTION" ]] || [[ "$USER" == "root" ]]; then
        user_host="%{$fg[green]%}%n@%m "
    fi

    # Build prompt
    PROMPT="${user_host}%{$fg[cyan]%}$(short_pwd)%{$reset_color%}\$(git_prompt_info)%{$reset_color%}
%{$fg[green]%}${prompt_char}%{$reset_color%} "
}

# Right prompt with minimal info
robbyrussell_rprompt() {
    # Only show exit code if non-zero
    RPROMPT='%(?..%{$fg[red]%}%?%{$reset_color%})'
}

# Initialize the prompt
robbyrussell_init() {
    # Set up prompt
    robbyrussell_prompt
    robbyrussell_rprompt

    # Enable prompt substitution
    setopt prompt_subst

    # Disable the default git dirty check delay
    export DISABLE_UNTRACKED_FILES_DIRTY=true
}

# Call initialization
robbyrussell_init