#!/usr/bin/env bash

emacs=$(pgrep emacs)

if [[ "$emacs" ]];
then
   emacsclient -nc
else
   emacs
fi
