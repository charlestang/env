#!/bin/bash
if [ ! -e /usr/local/bin/brew ]; then
    echo "Do you want to install brew? [YES/no]"
    read ANSWER
    if [ "$ANSWER" = "YES" ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
else
    echo "Congratulations! You've already installed brew."
fi
