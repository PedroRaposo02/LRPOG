#!/bin/bash

# this file copies the makefile to the selected directory and runs it

# if -c flag is used, then it runs make clean instead of make run

# check if -c flag is used
if [[ $1 == "-c" ]]; then
CLEAN__FLAG=1
fi

# get makefile name in current directory, either makefile or Makefile

MAKEFILE_NAME=$(ls | grep -i -E 'makefile|Makefile' | head -1)

# List the directories in the current directory, including the option for the current directory
directories=$(ls -d . */ 2>/dev/null)

# Check if there are any directories found
if [ -z "$directories" ]; then
  echo "No directories found in the current directory"
  exit 1
fi

# Add an option for the current directory
directories="${directories}"

# Prompt the user to select a directory
echo "Select a directory:"
select selected_directory in $directories; do
  if [ -n "$selected_directory" ]; then
    break
  fi
done

# Check if the selected directory is the current directory
if [ "$selected_directory" = "./" ]; then
  selected_directory=$(pwd)
fi

# Change to the selected directory
cd "$selected_directory"

# Copy the Makefile from the current directory to the selected directory, if it is not the current directory
if [ "$selected_directory" != "$(pwd)" ]; then
  cp "../$MAKEFILE_NAME" .
fi

if((CLEAN__FLAG)); then
  # Run the makefile
  make clean
  exit 0
fi
# Run the makefile
make run

# removes the makefile if not in current directory
rm "$MAKEFILE_NAME"