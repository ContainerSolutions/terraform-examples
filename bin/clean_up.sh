#!/bin/bash

# Script to remove all files created by terraform


cd - || exit 1

# Ignoring the file "./backends/remote/.terraformignore"
IGN_FILE=".terraformignore"

function repeat {
  read -p "Do you want to clean all the files created by terraform? (y/n) " yn
  case $yn in
  [yY])
    echo "================================================================================"
    echo "Removing all the files created by terraform"
    echo "================================================================================"
    find . -type f \( -name ".terraform.*" -o -name "terraform.*" \) -a ! -name ${IGN_FILE} -delete && find . -type d -name ".terraform" -exec rm -rf {} +
    # find . -type f -name ".terraform.*" -or -name "terraform.*" -and ! -name ".terraformignore"
    ;;
  [nN])
    exit
    ;;
  *)
    echo Invalid Response
    repeat
    ;;
  esac
}

repeat