#!/bin/bash

# Usage: ./script.sh
# The script will ask for necessary inputs.

echo "Enter GitHub username:"
read USERNAME

echo "Enter repository name:"
read REPO

echo "Is the repository private? (yes/no)"
read IS_PRIVATE

if [[ "$IS_PRIVATE" == "yes" ]]; then
    echo "Enter your GitHub personal access token:"
    read TOKEN
    URL="https://${TOKEN}@github.com/${USERNAME}/${REPO}.git"
else
    URL="https://github.com/${USERNAME}/${REPO}.git"
fi

echo "Enter your email for git config:"
read EMAIL

echo "Enter the filename of your SSH key (e.g., id_rsa):"
read SSH

echo "Enter the exact name of the file or directory to delete (e.g., obsolete_code.py or 'old folder/'):"
read FILENAME_TO_DELETE

# Clone the repository
git clone "$URL"
cd "$REPO"

# Perform actions on the repository
git checkout main
rm -rf "$FILENAME_TO_DELETE"  # Deletes the exact file or directory specified by the user, handling spaces properly
# work/abikesa_remove_duplicates.sh 

# Stage the deletions
git add -A 
# git add -u

# Commit the deletions
git commit -m "Removed '$FILENAME_TO_DELETE' from the repository" 

# Setup SSH (ensure you have configured SSH keys on your GitHub account)
ssh-add -D
chmod 600 "$(eval echo ~/.ssh/$SSH)"
git remote set-url origin "git@github.com:${USERNAME}/${REPO}"
ssh-add "$(eval echo ~/.ssh/$SSH)"

# Set local git configurations
git config --local user.name "$USERNAME"
git config --local user.email "$EMAIL"

# Push the changes
git push -u origin main
