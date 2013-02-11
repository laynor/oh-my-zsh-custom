# if using GNU screen, let the zsh tell screen what the title and hardstatus
# of the tab window should be.
if [[ "$TERM" == screen* ]]; then
    if [[ $_GET_PATH == '' ]]; then
        _GET_PATH='echo $PWD | sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"'
    fi
    if [[ $_GET_HOST == '' ]]; then
        _GET_HOST='echo $HOST | sed "s/\..*//"'
    fi

    # use the current user as the prefix of the current tab title
    TAB_TITLE_PREFIX='"`'$_GET_PATH' | sed "s:..*/::"`$PROMPT_CHAR"'
    # when at the shell prompt, show a truncated version of the current path (with
    # standard ~ replacement) as the rest of the title.
    TAB_TITLE_PROMPT='$SHELL:t'
    # when running a command, show the title of the command as the rest of the
    # title (truncate to drop the path to the command)
    TAB_TITLE_EXEC='$cmd[1]:t'

    # use the current path (with standard ~ replacement) in square brackets as the
    # prefix of the tab window hardstatus.
    TAB_HARDSTATUS_PREFIX='"[`'$_GET_PATH'`] "'
    # when at the shell prompt, use the shell name (truncated to remove the path to
    # the shell) as the rest of the title
    TAB_HARDSTATUS_PROMPT='$SHELL:t'
    # when running a command, show the command name and arguments as the rest of
    # the title
    TAB_HARDSTATUS_EXEC='$cmd'

    # tell GNU screen what the tab window title ($1) and the hardstatus($2) should be
    function screen_set()
    {
        # set the tab window title (%t) for screen
        print -nR $'\033k'$1$'\033'\\\

        # set hardstatus of tab window (%h) for screen
        print -nR $'\033]0;'$2$'\a'
    }
    # called by zsh before executing a command
    function preexec()
    {
        # local -a cmd; cmd=(${(z)1}) # the command string
        # eval "tab_title=$SCREEN_WIN_TITLE\\ \[$TAB_TITLE_PREFIX\]" # $TAB_TITLE_EXEC"
        # # eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX:$TAB_HARDSTATUS_EXEC"
        # eval "tab_hardstatus=$SCREEN_WIN_TITLE\\ \[$TAB_HARDSTATUS_PREFIX\]$TAB_HARDSTATUS_PROMPT"
        # screen_set $tab_title $tab_hardstatus

        screen -X title "$SCREEN_WIN_TITLE [`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"`]"
    }
    # called by zsh before showing the prompt
    function precmd()
    {
        screen -X title "$SCREEN_WIN_TITLE [`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"`]"
    }

    function screen_title()
    {
        export SCREEN_WIN_TITLE="$*"
        screen -X title "$SCREEN_WIN_TITLE [`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"`]"
    }

    function chpwd()
    {
        screen -X title "$SCREEN_WIN_TITLE [`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"`]"
    }

    screen -X title "$SCREEN_WIN_TITLE [`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"`]"

fi
