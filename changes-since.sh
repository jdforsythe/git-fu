#!/bin/bash

# did you pass all the arguments?
nl=$'\n'
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments${nl}USAGE: changes-since.sh \"Author Name\" \"2016-07-17\""
  exit 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments${nl}USAGE: changes-since.sh \"Author Name\" \"2016-07-17\""
  exit 2
fi

echo "${nl}Stats for ${1} since $2${nl}"
git log --numstat --pretty="%H" --author="$1" --since="$2" | awk 'NF==3 {count+=1; insertions+=$1; deletions+=$2} END {printf("%d file(s) changed, %d insertions(+), %d deletions(-), %d net", count, insertions, deletions, (insertions-deletions))}'
