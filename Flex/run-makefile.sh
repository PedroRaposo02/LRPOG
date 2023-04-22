#!/bin/bash

# this runs the makefile

TARGET=program

while getopts "nc" opt; do
    case $opt in
        n)
            echo "Running make with name"
            TARGET="$OPTARG" 
            flag=true
            ;;
        c)
            echo "Cleaning up"
            make clean
            clear
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done


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
  if [ ! -z "$selected_directory" ]; then
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
  cp "../makefile" .
fi

# List all files in the current directory with extension .flex
flex_files=$(ls *.flex *.l 2>/dev/null)

# Check if there are any .flex files found
if [ -z "$flex_files" ]; then
  echo "No .flex files found in the current directory"
  exit 1
fi

# Prompt the user to select a .flex file
echo "Select a .flex or .l file:"
select flex_file in $flex_files
do
  if [ ! -z "$flex_file" ]; then
    break
  fi
done

# List all files in the current directory with extension .txt
txt_files=$(ls *.txt 2>/dev/null)

# Check if there are any .txt files found
if [ -z "$txt_files" ]; then
  echo "No .txt files found in the current directory"
  exit 1
fi

# Prompt the user to select a .txt file
echo "Select a .txt file:"
select txt_file in $txt_files; do
  if [ ! -z "$txt_file" ]; then
    break
  fi
done


make FLEX="$flex_file" TXT="$txt_file" TARGET="$TARGET"
make clean

# Delete the Makefile from the selected directory, if it was copied
if [ "$selected_directory" != "$(pwd)" ]; then
  rm "makefile"
fi