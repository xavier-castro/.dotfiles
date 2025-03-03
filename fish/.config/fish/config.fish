if status is-interactive
    # Commands to run in interactive sessions can go here
end

if status --is-login
    set -gx PATH $PATH ~/.local/bin
    set -gx PATH $PATH ~/.local/bin/scripts
    set -gx PATH $PATH /usr/local/bin
    set -gx PATH $PATH /opt/homebrew/bin
    set -gx PATH $PATH ~/.cargo/bin
    set -gx PATH $PATH ~/.npm-global/bin
end
