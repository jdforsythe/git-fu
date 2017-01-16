#!/bin/bash
git stash list
echo "Enter stash number to rename"
read stash_number

echo "Enter new name"
read new_name

stash_name="stash@{${stash_number}}"
echo "$stash_name"

rev=$(git rev-parse $stash_name)

git stash drop $stash_name || exit 1
git stash store -m "$new_name" $rev
