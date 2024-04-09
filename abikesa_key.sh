# Fork/clone then create SSH key
cp -r got git
jb build git
ls -al ~/.ssh
ssh-keygen -t ed25519 -C "muzaalel@icloud.com" -f ~/.ssh/id_stata0elemental
echo "Please manually add the above SSH public key to your GitHub account's SSH keys."
read -p "Once you have added the SSH key to your GitHub account, press Enter to continue..."
cat ~/.ssh/id_stata3advanced.pub
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_onetwo

# Build the book with Jupyter Book
jb build stata3
git clone "https://github.com/abikesa/got"
cp -r git2/* got
cd $REPO_NAME
git add ./*
git commit -m "hardcoded git2/abikesa_key.sh; next: make user-driven"
chmod 600 ~/.ssh/id_git2got

# Configure the remote URL with SSH
git remote set-url origin "git@github.com:abikesa/got"

# Push changes
git push -u origin main
ghp-import -n -p -f _build/html
rm -rf got
echo "Jupyter Book content updated and pushed to abikesa/got repository!"

