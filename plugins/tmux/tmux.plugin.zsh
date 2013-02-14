# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [ -n "$TMUX" ]; then
  function mypwd() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=10
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
      NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
      NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
    echo $NEW_PWD
  }
  # called by zsh before executing a command
  function preexec()
  {
    tmux rename-window "$SCREEN_WIN_TITLE [`mypwd`]"
  }
  # called by zsh before showing the prompt
  function precmd()
  {
    tmux rename-window "$SCREEN_WIN_TITLE [`mypwd`]"
  }

  function tmux-title()
  {
    export SCREEN_WIN_TITLE="$*"
    tmux rename-window "$SCREEN_WIN_TITLE [`mypwd`]"
  }

  function chpwd()
  {
    tmux rename-window "$SCREEN_WIN_TITLE [`mypwd`]"
  }

  tmux rename-window "$SCREEN_WIN_TITLE [`mypwd`]"
fi
