if status is-interactive
    # Commands to run in interactive sessions can go here
  export EDITOR=nvim
  set fzf_dir_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
  set -g fish_key_bindings fish_vi_key_bindings
  set fzf_preview_dir_cmd exa --all --color=always
  bind -M insert \cc kill-whole-line repaint
  fzf_configure_bindings --directory=\cf --variables=\e\cv
end
