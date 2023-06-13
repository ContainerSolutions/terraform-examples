#!/bin/bash

# Script to remove all files created by terraform

cd - || exit 1

# Ignoring the file "./backends/remote/.terraformignore"
IGN_FILE=".terraformignore"

echo "================================================================================"
echo "Removing all the files created by terraform"
echo "================================================================================"
find . -type f \( -name ".terraform.*" -o -name "terraform.*" \) -a ! -name ${IGN_FILE} -delete && find . -type d -name ".terraform" -exec rm -rf {} +
