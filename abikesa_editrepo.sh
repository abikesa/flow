#!/bin/bash

# Usage: ./script.sh <username> <repo> [token]
# Example for public repo: ./script.sh jhustata basic
# Example for private repo: ./script.sh jhustata private-repo ghp_xxxxxxxxxxxx

USERNAME=$1
REPO=$2
TOKEN=$3
EMAIL=$4 
SSH=$5

# Check if token was provided
if [ -n "$TOKEN" ]; then
    URL="https://${TOKEN}@github.com/${USERNAME}/${REPO}.git"
else
    URL="https://github.com/${USERNAME}/${REPO}.git"
fi

# Clone the repository
git clone $URL
cd $REPO

# Perform actions on the repository
git checkout main
rm -rf ssh*  # Assumes you want to delete files starting with 'ssh'

# Stage the deletions
git add -A 

# Commit the deletions
git commit -m "Removed ssh files in main directory" 

# Setup SSH (ensure you have configured SSH keys on your GitHub account)
ssh-add -D
chmod 600 "$(eval echo ~/.ssh/$SSH)"
git remote set-url origin "git@github.com:${USERNAME}/${REPO}"
ssh-add "$(eval echo ~/.ssh/$SSH)"

# Set local git configurations
git config --local user.name "$USERNAME"
git config --local user.email "${$EMAIL"  # Adjust as necessary

# Push the changes
git push -u origin main
