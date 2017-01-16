#!/bin/bash

# did you pass all the arguments?
nl=$'\n'
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments${nl}USAGE: resolve-pr-conflicts.sh \"merge-to-branch\" \"merge-from-branch\""
  exit 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: too many arguments${nl}USAGE: resolve-pr-conflicts.sh \"merge-to-branch\" \"merge-from-branch\""
  exit 2
fi

parent_branch="${1}"
pr_branch="${2}"

####################

branch_exists() (
  ## return the existence of the branch in git branch command
  ## redirect grep output to /dev/null since we only care about the exit code
  git branch | grep $parent_branch > /dev/null
)

run_merge_tool() (
  git mergetool

  echo "${nl}Did you finish fixing conflicts? Should I:${nl}${nl}"
  echo "  1. Fix conflicts again"
  echo "  2. Push fixes"
  echo "${nl}"
  read do_what

  if [ "${do_what}" == "1" ]; then
    merge_tool
  elif [ "${do_what}" == "2" ]; then
    git commit --no-edit
    git push
    echo "Check on Github - PR should be able to merge"
  fi
)

####################

# Make sure both parent_branch and pr_branch are created locally and the latest changes are pulled

echo "${nl}Creating or updating local $pr_branch${nl}"
git fetch origin

# PARENT branch
if branch_exists "$parent_branch"; then
  git checkout "$parent_branch"
  git pull

else
  git checkout -b "$parent_branch" "origin/$parent_branch"

fi

# PR branch
if branch_exists "$pr_branch"; then
  git checkout "$pr_branch"
  git pull

else
  git checkout -b "$pr_branch" "origin/$pr_branch"

fi

# Merge PARENT into PR and run mergetool to fix conflicts
echo "${nl}Merging ${nl}"
git checkout "$parent_branch"
git merge wireless

echo "${nl}Running mergetool to fix conflicts${nl}"
run_merge_tool
