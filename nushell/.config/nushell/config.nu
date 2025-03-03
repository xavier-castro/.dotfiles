# ~/.config/nushell/config.nu

# Environment variables
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Add paths to PATH
$env.PATH = ($env.PATH | split row (char esep) | append [
    "~/.local/bin"
    "~/.local/bin/scripts"
    "/usr/local/bin"
    "/opt/homebrew/bin"  # For macOS Homebrew
    "~/.cargo/bin"       # For Rust tools
    "~/.npm-global/bin"  # For global NPM packages
])

# Remove any duplicate paths while preserving order
$env.PATH = ($env.PATH | uniq)

# Optional: Set a more readable datetime format
$env.FILESIZE_METRIC = true
$env.TIMEFORMAT = "%Y-%m-%d %H:%M:%S"

# Disable Banner
$env.config = {
show_banner: false
}

# Have MacOS still work with open
alias nu-open = open
alias open = ^open