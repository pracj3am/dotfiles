alias sniff="sudo ngrep -W byline -d 'eth1' -t '^(GET|POST) ' 'tcp and port 80'"

# list total disk usage for current folder contents
alias use="/bin/ls -1A | tr '\n' '\0' | xargs -0 du -skh"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


