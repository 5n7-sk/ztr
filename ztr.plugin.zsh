autoload -Uz vcs_info

function rename_window() {
  vcs_info

  if [[ -n "$vcs_info_msg_0_" ]]; then
    dir=`git rev-parse --show-toplevel`
    IFS="/\\", read -Ar array <<< "$dir"
    tmux rename-window "${array[-2]}/${array[-1]}"
  else
    tmux rename-window "${PWD##*/}"
  fi
}

zstyle ":vcs_info:*" enable git

autoload -Uz add-zsh-hook
add-zsh-hook chpwd rename_window

[[ -z "$TMUX" ]] || rename_window
