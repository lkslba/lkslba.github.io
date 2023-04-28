#!/usr/bin/env sh
#
# set the source and destination file paths
SOURCE_FILE="/Users/lkslba/Documents/emacs/org/Uni/Biologie/Pflanzenökologie/Pflanzenökologie.org"
DESTINATION_FOLDER="/Users/lkslba/Documents/emacs/org/pers_ws/content/lecture-notes"

# check if the source file exists
if [ -f "$SOURCE_FILE" ]; then
  # create the destination folder if it doesn't exist
  mkdir -p "$DESTINATION_FOLDER"

  # copy the file to the destination folder
  cp "$SOURCE_FILE" "$DESTINATION_FOLDER"

  echo "File copied successfully."
  emacs -Q --script build-site.el

else
  echo "Source file not found."
  emacs -Q --script build-site.el
fi
