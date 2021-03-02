# default, insert, replace_one, visual

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo '☐ '
    case '*'
      echo ''
  end
  set_color normal
end
