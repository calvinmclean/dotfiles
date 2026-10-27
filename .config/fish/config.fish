alias t='task'
alias g='git'
alias tm='tmux'

set --export EDITOR vim
if test -d "$HOME/go/bin"
    fish_add_path --prepend "$HOME/go/bin"
end
if test -d /opt/homebrew/bin
    fish_add_path --prepend /opt/homebrew/bin
end

if status is-interactive
    fzf --fish | source

    zoxide init fish | source
    alias zwt='z (t lwt)'
    alias cd='z'
end

fish_vi_key_bindings
