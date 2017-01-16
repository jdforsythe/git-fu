#!/bin/bash

echo "Cleaning git merge conflict artifacts..."
find . -name "*.bak" | while read filename; do echo "Removing: $filename" && rm -rf "$filename"; done
echo -e "\n"

echo "Counting unreachable objects in git database..."
unreachable=$(git fsck --unreachable | wc -l)
echo "There are $unreachable unreachable objects."

if [ $unreachable -gt 0 ]; then
  echo "Cleaning unreachable objects.."
  git prune
fi

echo -e "\n"

echo "Packing unpacked objects..."
git repack -a -d -l
echo -e "\n"

echo "Forcing garbage collection..."
git gc --aggressive
echo -e "\n"

echo "Done."
