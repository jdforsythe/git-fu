#!/bin/bash

# $1 is the main ancestor branch to compare to
# comparison comes from the current branch

diff --old-line-format='' --new-line-format='' <(git rev-list --first-parent "${1:-master}") <(git rev-list --first-parent "${2:-HEAD}") | head -1
