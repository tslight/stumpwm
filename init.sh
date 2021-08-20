#!/usr/bin/env bash

xsetroot -cursor_name left_ptr -solid grey9
xset r rate 200 50 s 240 dpms 480 600 820
xrdb ~/.Xresources

command -v alttab &> /dev/null && alttab -vp pointer -d 1

if command -v redshift &> /dev/null; then
    sct 4000
elif command -v redshift &> /dev/null; then
    redshift -P -O 4000
fi

XAUTOLOCK=$(command -v xautolock &> /dev/null && echo "true")
SLOCK=$(command -v slock &> /dev/null && echo "true")

[[ $XAUTOLOCK && $SLOCK ]] && xautolock -locker slock &

command -v dropbox &> /dev/null && dropbox start
