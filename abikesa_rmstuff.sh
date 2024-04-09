# $TOKEN if private repo
git clone "https://$TOKEN@github.com/$REPO_URL.git"

# Switch to the main branch
cd "$(basename "$REPO_URL")"

# Remove the specified path (can be directory, file, or file type)
rm -rf $DELETE_PATH

# Stage, commit, and push deletions
git add -A 
git commit -m "Removed $DELETE_PATH in main directory"
git remote -v

# Permissions for access
chmod 600 "$(eval echo $SSH_KEY_PATH)"
git remote set-url origin "git@github.com:$GITHUB_USERNAME/$REPO_NAME"
ssh-add "$(eval echo $SSH_KEY_PATH)"
git config --local user.name "$GITHUB_USERNAME"
git config --local user.email "$EMAIL_ADDRESS"

# Checkout the main branch
git checkout main
git push -u origin main