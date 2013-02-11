LOGS_DIR=$HOME/.logs/zsh/`\date "+%Y"`/`\date "+%m-%B"`/`\date "+%d"`
HL_TTY=`tty | sed "{s/\/dev\///g}"| sed "{s/\///g}"`
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

    if [ "$(id -u)" -ne 0 ]; then

        FULL_CMD_LOG=$LOGS_DIR/history-$__HL_SESSION_START-$HL_TTY.log

        echo "$HL_LOG_PREFIX`pwd| sed "s/^\/Users\//~/;s/^\/home\//~/;s/^~$USER/~/"` [$(date)]  `fc -ln -1`" >> ${FULL_CMD_LOG};

    fi
}


add-zsh-hook precmd hl_precmd
