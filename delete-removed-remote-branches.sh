#!/bin/bash

get_deleted() {
  git branch -vv | awk '$3 $4 ~ /:gone]$/ { print $1 }'
}

nl=$'\n'
echo "Cleaning branches tracking remotes that no longer exist.${nl}${nl}"
echo "Enter your main development branch:${nl}"
read -p "Branch: (master) " main_branch
main_branch=${main_branch:-master}

echo "Checking out ${main_branch}${nl}"
git checkout "${main_branch}"
echo "${nl}"

echo "Updating branch metadata${nl}"
git fetch --all -p
echo "${nl}"

initial_count=$(get_deleted | wc -l)
echo "${initial_count} branches with deleted remotes${nl}"

if [ $initial_count -gt 0 ]; then
  get_deleted
  echo "${nl}"

  echo "Deleting branches...${nl}"
  get_deleted | xargs -n 1 git branch -d

  ## maybe all of the branches didn't delete - this can be caused by having changes that weren't
  ## merged, or by squash-merging on the remote so it looks like it wasn't merged
  echo "Checking for branches that didn't delete${nl}"
  leftover_count=$(get_deleted | wc -l)
  echo "${leftover_count} branches left over${nl}"
  if [ $leftover_count -gt 0 ]; then
    echo "This could be due to changes that have not been merged OR if the remote branches"
    echo "were squashed and merged. Do you want to force delete the remaining branches?"
    read -p "Force delete: y|n (n) " force_delete
    force_delete=${force_delete:-no}

    if [[ $force_delete == "yes" || $force_delete == "y" || $force_delete == "Y" || $force_delete == "YES" ]]; then
      echo "Force deleting ${leftover_count} remaining branches${nl}"
      get_deleted | xargs -n 1 git branch -D
      echo "Done.${nl}"
    fi
  fi
fi

echo "${nl}"
echo "Finished."
