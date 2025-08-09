#!/bin/bash

rm -i merged.md

# Loop through each text file in the directory
for file in *.md ; do
    # Append the file name as a section header
    echo "=== $file ===" >> merged.md
    # Append the contents of the file to the destination file
    cat "$file" >> merged.md
    # Add an empty line between sections
    echo "" >> merged.md
done
