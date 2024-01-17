#!/bin/bash

# File paths
output_file="/Users/apple/Documents/Documents/GIT/simplebank-master/user_output.txt"
md5_file="/var/log/current_users"
changes_file="/var/log/user_changes"

# Run the first script and store the output
./get_users.sh > "$output_file"

# Calculate MD5 hash
md5sum=$(md5 -q "$output_file")

# Check if this is the first run
if [ ! -f "$md5_file" ]; then
  echo "$md5sum" > "$md5_file"
else
  # Compare with the stored MD5 hash
  stored_md5=$(cat "$md5_file")
  if [ "$md5sum" != "$stored_md5" ]; then
    # Log changes and update MD5 file
    date_time=$(date +"%Y-%m-%d %H:%M:%S")
    changes=$(comm -23 <(sort "$output_file") <(sort "$md5_file"))
    
    # Filter out system accounts
    changes=$(grep -E -v '^_' <<< "$changes")
    
    if [ -n "$changes" ]; then
      echo "$date_time changes occurred: $changes" >> "$changes_file"
      echo "$md5sum" > "$md5_file"
    fi
  fi
fi

# Clean up temporary file
rm "$output_file"