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
local ale_p_um_cat='%{$reset_color%}%{$fg[blue]%}'
local ale_p_um_cm='%{$reset_color%}%{$fg[red]%}'
local ale_p_um_cbrac='%{$reset_color$fg[white]%}'
local ale_p_um=$ale_p_um_cbrac'['$ale_p_um_cu'%n'$ale_p_um_cat'@'$ale_p_um_cm'%m'$ale_p_um_cbrac']'

local ale_p_pwd_c='%{$reset_color%}%{$fg_bold[magenta]%}'
local ale_p_pwd=$ale_p_pwd_c'${PWD/#$HOME/~}'

parse_git_branch() {
	branch=`git branch --no-color 2> /dev/null | \grep  '*' | sed s/\*\ //`
	if [[ -n "$branch" ]]; then
		printf " [%s]" $branch
	else
		echo ""
	fi
}
local git_branch='$(parse_git_branch)%{$reset_color%}' #'$(git_prompt_info)%{$reset_color%}'
local ale_p_git_c='%{$reset_color%}%{$fg[white]%}'
local ale_p_git=$ale_p_git_c$git_branch

local ale_p_end_c='%{$reset_color%}%{$fg_bold[green]%}'
local ale_p_end=$ale_p_end_c' %(!.#.►) '

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"

function precmd {
    if [[ $? == 0 ]]; then
	echo $fg_bold[green]':-)'$reset_color
    else
	echo '['$fg_bold[red]$?$reset_color']'$fg_bold[red] ":-("$reset_color
    fi
}

PROMPT=$ale_p_um' '$ale_p_pwd$ale_p_git$ale_p_end
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

RPROMPT='${return_status}[ %T ]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" ( "
ZSH_THEME_GIT_PROMPT_SUFFIX=" )"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
