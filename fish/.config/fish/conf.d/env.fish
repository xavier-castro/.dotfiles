# Ultra-minimal fish environment variables - absolute essentials only
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
fish_add_path "$HOME/.local/bin" "$HOME/.local/scripts"

# Load private env vars
if test -f "$HOME/.config/fish/private.fish"
  source "$HOME/.config/fish/private.fish"
end
