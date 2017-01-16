#!/bin/bash

if [ ! -f .mailmap ]; then
  echo "WARNING: File .mailmap not found. If you get multiples of names check:"
  echo "https://git-scm.com/docs/git-blame#_mapping_authors"
  echo ""
  echo "--------------------"
  echo ""
fi

git ls-tree -r -z --name-only HEAD -- . | xargs -0 -n1 git blame --line-porcelain HEAD | sed -n 's/^author //p' | sort | uniq -c | sort -nr
