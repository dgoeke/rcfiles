function tmux_autostart
  function exit
    if [ "$TERM" = "screen-256color" ]
      tmux detach -P
    else
      builtin exit
    end
  end

  if not set -q TMUX
    set -g TMUX tmux new-session -d -s base
    eval $TMUX
    tmux attach-session -d -t base
  end
end
