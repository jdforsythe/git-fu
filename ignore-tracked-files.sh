#!/bin/bash

echo "Add your files/folders to .gitignore before running this"
echo "and run this from the root of the project"
echo "Press enter to continue"

git rm -r --cached .
git add .

echo "Now commit the changes"
