alias ls='ls --color=auto --group-directories-first'
alias makedebug='make DEBUG="-O0 -gdwarf-4 -g3 -fvar-tracking-assignments"'
alias zsed='sed -r '
alias rckill="pgrep -lf python| grep -i remote | sed  's/\([0-9][0-9]*\).*/\1/' | xargs kill"
alias tt='~/Dropbox/timetable.py ~/Documenti/timetable.txt'
alias ex='extract'
alias grep='grep -nI'
alias date='date "+%a %Y-%m-%d %H:%M"'

#emacs
alias e='emacsclient --alternate-editor="" -c' 
alias en='emacsclient --alternate-editor="" -nw'

# ls
unalias la
alias l='ls++ --potsf'
alias la='l -A'
alias axel='axel --alternate'
