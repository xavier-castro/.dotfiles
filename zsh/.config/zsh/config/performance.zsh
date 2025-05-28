# Performance tracking for zsh startup
# Uncomment the following line to enable startup profiling
# zmodload zsh/zprof

# Function to measure zsh startup time
zsh-startup-time() {
  for i in {1..10}; do
    time zsh -i -c exit
  done
}

# Function to profile zsh startup
zsh-profile() {
  zsh -i -c 'zprof' | less
}