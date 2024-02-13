function fish_right_prompt
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged " "
  set -l dirty    "⨯"
  set -l none     ""

  set -l directory_color  (set_color 76684a)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)
  set -l translucent_color     (set_color 404040)
  set -l git_color             (set_color 7C5843)
  set -l clock_color           (set_color 637378)

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end
  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end
    echo -n -s $directory_color " " $translucent_color $cwd " " 
    echo -n -s $git_color "  " $translucent_color (git_branch_name) " "
    if git_is_touched
      echo -n -s $dirty " "
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
echo -n -s $directory_color " " $translucent_color $cwd " "
  end
  echo -n -s $clock_color "  " $translucent_color
  date "+%I:%M:%S %p"
end
