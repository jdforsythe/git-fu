#!/bin/bash

# did you pass all the arguments?
nl=$'\n'
if [ $# -lt 3 ]; then
  echo 1>&2 "$0: not enough arguments${nl}USAGE: changes-between-commits.sh \"Author Name\" FROM_COMMIT_SHA TO_COMMIT_SHA"
  exit 2
elif [ $# -gt 3 ]; then
  echo 1>&2 "$0: too many arguments${nl}USAGE: changes-between-commits.sh \"Author Name\" FROM_COMMIT_SHA TO_COMMIT_SHA"
  exit 2
fi

echo "${nl}Stats for ${1} from $2..$3${nl}"
git log --numstat --pretty="%H" --author="$1" $2..$3 | awk 'NF==3 {count+=1; insertions+=$1; deletions+=$2} END {printf("%d file(s) changed, %d insertions(+), %d deletions(-), %d net", count, insertions, deletions, (insertions-deletions))}'
