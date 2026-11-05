#!/bin/bash

if ! /usr/bin/pgrep -u "$(/usr/bin/id -u)" -x OneDrive >/dev/null; then
    /bin/mkdir -p "$HOME/Library/Logs/local.onedrive.watchdog" || exit 1
    if /usr/bin/open -g /Applications/OneDrive.app; then
        /bin/date '+%Y-%m-%d %H:%M:%S %z OneDrive 未运行，已执行启动' >> "$HOME/Library/Logs/local.onedrive.watchdog/watchdog.log"
    fi
fi
