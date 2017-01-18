# Git Fu
Git utility and statistical scripts

## Utility Scripts

- `clean-merge-conflicts.sh` - Cleans any `*.bak` files left over from merge tools

- `clean-repo.sh` - Cleans repo of merge conflict artifacts and unreachable objects, packs unpacked objects, and forces garbage collection

- `delete-removed-remote-branches.sh` - Deletes local copies of branches where the branch they were tracking on the remote has been deleted (merged PRs, for example)

- `oldest-ancestor.sh` - Find the oldest ancestor (SHA) of the current branch

- `rename-stash.sh` - Change the name (message) of an existing stash

- `resolve-pr-conflicts.sh` - Help solve PR conflicts from GitHub - helps you fix conflicts but pushes changes back to the PR when conflicts are fixed instead of manually merging the PR
  - `resolve-pr-conflicts.sh "parent-branch-name" "pr-branch-name"`

## Statistical Scripts

- `changes-between-commits.sh` - Summary (counts) of changes for an author between two commits
  - `changes-between-commits.sh "Author Name" FROM_SHA TO_SHA`

- `changes-since.sh` - Summary (counts) of changes for an author since a certain date
  - `changes-since.sh "Author Name" "YYYY-MM-DD"`

- `commits-per-author.sh` - Shows count of commits per author, excluding merge commits (requires `.mailmap` file)

- `lines-per-author.sh` - Shows the number of lines of code written by each author


