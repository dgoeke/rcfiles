function fish_user_key_bindings
  set -U fish_cursor_default block
  set -U fish_cursor_insert line
  set -U fish_cursor visual block
  set -U fish_cursor replace underscore

  fish_vi_key_bindings
  fish_vi_cursor
end
