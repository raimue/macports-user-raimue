#!/usr/bin/env bash

for p in "$@"; do
    file=$(port file $p)
    revold=$(grep ^revision "$file" | awk '{print $2}')
    if [ -n "$revold" ]; then
        revnew=$(expr $revold + 1)
        echo "$p: revision $revold -> $revnew"
        sed -i "" /^revision/s/$revold/$revnew/ "$file"
    else
        echo "$p: revision 0 -> 1"
        gawk -i inplace '
            BEGIN { done = 0 }
            // { print $0 }
            done == 0 && /^(version|(github|perl).setup)/ {
                match($0, /^([a-z.]+)(\s+)/, arr);
                printf "revision%*s1\n", RLENGTH - 8, "";
                done = 1
            }
            ' "$file"
    fi
done
