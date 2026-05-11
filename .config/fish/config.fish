alias t='task'
alias g='git'
alias zwt='z (t lwt)'

set --export EDITOR vim
set --export --prepend PATH "/Users/calvinmclean/go/bin"
set --export --prepend PATH "/opt/homebrew/bin"

fzf --fish | source

zoxide init fish | source

fish_vi_key_bindings
