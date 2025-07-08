# ~/.zprofile
# Login shell tweaks (rarely used in GUI Terminal)

# macOS-specific login shell setup
if [[ "$OSTYPE" == darwin* ]]; then
  # Evaluate path_helper on macOS
  eval $(/usr/libexec/path_helper -s)
fi

# Set up any login-specific configurations here
# (This file is typically minimal or empty for GUI terminal users)


# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

