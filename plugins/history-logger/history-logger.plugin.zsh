#
# History logging plugin for oh-my-zsh
#
# This plugins lets the user customize of how and where his history gets saved.
# It is to be used in addition to, and not instead of, the standard .history
# method, and changes nothing of the standard history handling of Zsh. It is
# merely a way to have a more thorough control of the history. It is based on
# the work of Andrew Hays[1] (http://blog.andrewhays.net/) and Nick Mote[2]
# (http://motespace.com/blog/).
#
# By default, the plugin creates the directory $HOME/.logs/zsh/[current year]/[current month]/[current day]
# where the log files will be stored. The log file name is history-[year]-[month]-[day]-[tty].log,
# where day, month and year refer to the currect session start time.
#
# Each command executed on the shell gets written with an extensive preable:
# [user]@[host] - [tty] - [current directory] - [execution time] [cmd]
#
# Customization:
#
# LOGS_DIR: set this to where you would like the plugin to store the logs.
# HL_TTY: set this to what you want the tty string to look like
# HL_LOG_PREFIX: set this to what you would like the command log to begin with.
#
# Authors:
#
# Mattia Ziulu (mziulu@gmail.com)
# Alessandro Piras (laynor@gmail.com)
#
# Notes:
#
# [1]: http://blog.andrewhays.net/love-your-terminal
# [2]: http://motespace.com/blog/2011/03/12/saving-command-line-history/
#

LOGS_DIR=$HOME/.logs/zsh/`\date "+%Y"`/`\date "+%m-%B"`/`\date "+%d"`
HL_TTY=`tty | sed "{s/\/dev\///g}" | sed "{s/\///g}"`
HL_LOG_PREFIX="$USER@`hostname`-`tty`:"
__HL_SESSION_START=$(\date +%Y-%m-%d)

function hl_create_dirs() {
    if [ ! -d "$LOGS_DIR" ]; then
        mkdir -p $LOGS_DIR
    fi
}

function hl_precmd() {
    if [ ! $HL_INITIALIZED ]; then
        export HL_INITIALIZED=1
        hl_create_dirs
    fi

    FULL_CMD_LOG=$LOGS_DIR/history-$__HL_SESSION_START-$HL_TTY.log
    echo "$HL_LOG_PREFIX`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"` [$(date)]  `fc -ln -1`" >> ${FULL_CMD_LOG};
}

add-zsh-hook precmd hl_precmd
