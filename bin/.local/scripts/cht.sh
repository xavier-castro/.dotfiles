#!/usr/bin/env bash
languages=`echo "typescript tailwindcss react javascript" | tr ' ' '\n'`
core_utils=`echo "xargs find mv sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
read -p "query: " query

if printf $languages | grep -qs $selected; then
   tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
    echo "language"
else
       tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi

# https://www.youtube.com/watch?v=hJzqEAf2U4I
