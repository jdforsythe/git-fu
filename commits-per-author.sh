#!/bin/bash

if [ ! -f .mailmap ]; then
  echo "WARNING: File .mailmap not found. If you get multiples of names check:"
  echo "https://git-scm.com/docs/git-shortlog#_mapping_authors"
  echo ""
  echo "--------------------"
  echo ""
fi

# default to the entire history of the repo
if [ $# -lt 1 ]; then
  git shortlog -s -n -e --all --no-merges
else
  git shortlog -s -n -e --all --no-merges ${1}..
fi
