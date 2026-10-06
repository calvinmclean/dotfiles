function __ghostty_tmux_attach
    commandline --replace 'tmux attach'
    commandline --function execute
end

for mode in insert default
    bind --mode $mode \cb __ghostty_tmux_attach
    bind --mode $mode \ef __ghostty_tmux_attach
end
