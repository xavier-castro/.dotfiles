# Globbing and matching
setopt extendedglob       # Extended globbing patterns
setopt nocaseglob         # Case-insensitive globbing
setopt rcexpandparam      # Array expansion with parameters
setopt glob_complete      # Generate matches for globbing

# History
setopt appendhistory          # Append to history file
setopt inc_append_history     # Add commands immediately
setopt share_history          # Share history between sessions
setopt hist_expire_dups_first # Expire duplicates first
setopt hist_ignore_dups       # Ignore duplicates
setopt hist_ignore_space      # Ignore commands starting with space
setopt hist_verify            # Show command before executing from history
setopt hist_reduce_blanks     # Remove extra blanks from commands

# Navigation
setopt autocd             # Change directory without cd
setopt auto_pushd         # Push directories onto stack
setopt pushd_ignore_dups  # Don't push duplicates
setopt pushd_minus        # Exchange + and - meanings

# Completion
setopt always_to_end      # Move cursor to end after completion
setopt complete_in_word   # Complete from cursor position
setopt list_packed        # Compact completion lists
setopt list_types         # Show file types in completion
setopt menu_complete      # Auto-select first completion match

# Corrections
setopt correct            # Suggest command corrections
unsetopt correct_all      # Don't correct arguments

# Misc
setopt nobeep            # No beeping
setopt interactive_comments  # Allow comments in interactive mode
setopt multios           # Enable multiple redirections
setopt prompt_subst      # Expand parameters in prompt

# Performance optimizations
setopt no_bg_nice        # Don't nice background jobs
setopt no_hup            # Don't send HUP to jobs on exit
setopt no_check_jobs     # Don't warn about background jobs on exit