function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l fish    " " 
  set -l arrow_color      (set_color e68147)
  set -l normal_color     (set_color normal)
  set -l error_color      (set_color b02c34)

  if test $last_command_status -eq 0
    echo -n -s $arrow_color $fish $normal_color
  else
    echo -n -s $error_color $fish $normal_color
  end
end
