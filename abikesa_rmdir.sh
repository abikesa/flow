#!/bin/bash

# Variables
TOKEN="$1"
REPO_URL="$2"
DELETE_PATH="$3"
SSH_KEY_PATH="$4"
USERNAME="$5"
EMAIL="$6"

# Clone the repo
git clone "https://$TOKEN@github.com/$REPO_URL.git"
cd "$(basename "$REPO_URL")"

# Switch to the main branch
git checkout main

# Remove the specified path (can be directory, file, or file type)
rm -r $DELETE_PATH

# Stage, commit, and push deletions
git add -A 
git commit -m "Removed $DELETE_PATH in main directory"
git remote -v

# Unblock if repo linked to ~/.ssh/id_etc

# ssh-add -D 
# chmod 600 "$SSH_KEY_PATH"

git remote set-url origin "git@github.com:$REPO_URL.git"

# ssh-add "$SSH_KEY_PATH"

git config --local user.name "$USERNAME"
git config --local user.email "$EMAIL"
git push -u origin main

cd "$(basename "older_gfr")"

origin  https://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@github.com/fawazalammary/older_gfr (fetch)