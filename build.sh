#!/usr/bin/env sh
#
# set the source and destination file paths
src_dir="/Users/lkslba/Documents/emacs/org/roam"
dest_dir="/Users/lkslba/Documents/emacs/org/pers_ws/content/lecture-notes"
img_dir_name="images"
img_dir_path="${dest_dir}/${img_dir_name}"

# create the destination directory and images directory if they don't exist
mkdir -p "$dest_dir"
mkdir -p "$img_dir_path"

# copy all files starting with "vorlesung_" and ending with ".org"
# and all image files to their respective directories
find "$src_dir" -type f -name "*vorlesung_*.org" -exec cp {} "$dest_dir" \;

find "$src_dir" -type d -name "$img_dir_name" -exec cp -r {}/. "$img_dir_path" \;

# check if any files were copied
if [ "$(ls -A "$dest_dir")" ]; then
  echo "Files copied successfully."
  emacs -Q --script build-site.el
else
  echo "No files were found to copy."
  emacs -Q --script build-site.el
fi
