alias ls='ls --color=auto --group-directories-first'
alias makedebug='make DEBUG="-O0 -gdwarf-4 -g3 -fvar-tracking-assignments"'
alias zsed='sed -r '
alias rckill="pgrep -lf python| grep -i remote | sed  's/\([0-9][0-9]*\).*/\1/' | xargs kill"
alias tt='~/Dropbox/timetable.py ~/Documenti/timetable.txt'
alias ex='extract'
alias grep='grep -nI'
alias date='date "+%a %Y-%m-%d %H:%M"'
unalias la
alias la='ls++ --potsf -A'
alias l='ls++ --potsf'
alias e='EMACS_PROFILE=home-linux emacsclient --alternate-editor="" -c' 
alias en='EMACS_PROFILE=home-linux emacsclient --alternate-editor="" -nw'
