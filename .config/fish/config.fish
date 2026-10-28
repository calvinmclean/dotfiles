alias t='task'
alias g='git'
alias tm='tmux'

function discotime --description 'Run Discobox with customized harness images'
    env DISCOBOX_HARNESS_SHELL_IMAGE=ghcr.io/calvinmclean/discotime:shell \
        DISCOBOX_HARNESS_CLAUDE_CODE_IMAGE=ghcr.io/calvinmclean/discotime:claude-code \
        DISCOBOX_HARNESS_CODEX_IMAGE=ghcr.io/calvinmclean/discotime:codex \
        discobox $argv
end

set --export EDITOR vim
if test -d "$HOME/.rd/bin"
    fish_add_path --path --prepend "$HOME/.rd/bin"
end
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
