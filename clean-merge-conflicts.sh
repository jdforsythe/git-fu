#!/bin/bash
find . -name "*.bak" | while read filename; do echo "Removing merge conflict artifact: $filename" && rm -rf "$filename"; done
echo "Done."
