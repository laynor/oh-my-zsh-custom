# -*- sh -*-
# ZSH Theme emulating the Fish shell's default prompt.
function collapse_pwd {
	echo $(pwd | sed -e "s,^$HOME,~,")
}

local user_color='green'; [ $UID -eq 0 ] && user_color='red'
#($fg_bold[red]$(git_prompt_info)$(git_prompt_status))
#PROMPT='%n@%m %{$fg[$user_color]%}%~%{$reset_color%} (%{$fg_bold[red]%}$(git_prompt_info)$(git_prompt_status)) %(!.#.>) '
# ultimo carattere del prompt
# USER AND MACHINE
local ale_p_um_cu='%{$fg_bold[grey]%}'
local ale_p_um_cat='%{$reset_color$fg[blue]%}'
local ale_p_um_cm='%{$reset_color$fg[red]%}'
local ale_p_um_cbrac='%{$reset_color$fg[white]%}'
local ale_p_um=$ale_p_um_cbrac'['$ale_p_um_cu'%n'$ale_p_um_cat'@'$ale_p_um_cm'%m'$ale_p_um_cbrac']'

local ale_p_pwd_c='%{$reset_color$fg_bold[magenta]%}'
local ale_p_pwd=$ale_p_pwd_c'${PWD/#$HOME/~}'

function parse_git_branch() {
	branch=`git branch --no-color 2> /dev/null | \grep  '*' | sed s/\*\ //`
	if [[ -n "$branch" ]]; then
		printf " [%s]" $branch
	else
		echo ""
	fi
}
# local git_branch='$(parse_git_branch)%{$reset_color%}' #'$(git_prompt_info)%{$reset_color%}'
local git_branch='$(git_prompt_info)$(git_remote_status)'
local ale_p_git_c='%{$reset_color$fg[white]%}'
local ale_p_git=$ale_p_git_c$git_branch

local ale_p_end_c='%{$reset_color$fg_bold[green]%}'
local ale_p_end=$ale_p_end_c' %(!.#.►) '

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"

function precmd {
    if [[ $? == 0 ]]; then
	echo $fg_bold[green]':-)'$reset_color
    else
	echo $fg_bold[red]":-("$reset_color
    fi
}

function rvm-info () {
    if which rvm-prompt &> /dev/null; then
        local foo=`rvm-prompt | cut -sd '@' -f2`
        if [[ $foo != "" ]]; then
            echo "(%{$fg_bold[red]%}gem:$foo%{$reset_color%})"
        fi
    fi
}
# Checks if working tree is dirty
parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
          SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
      eval "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
  fi
}
ale_p_rvm='$(rvm-info)'
PROMPT=$ale_p_rvm$ale_p_um' '$ale_p_pwd$ale_p_git$ale_p_end
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

RPROMPT='${return_status}[ %T ]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" ["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="git_prompt_status"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ●%{$reset_color%}"

# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]✓%}"
ZSH_THEME_GIT_PROMPT_CLEAN=''

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}R"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}U"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg[cyan]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg[cyan]%}↑"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[cyan]%}↕"
