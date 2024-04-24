# Fork/clone then create SSH key
cp -r got git
jb build git
ls -al ~/.ssh
ssh-keygen -t ed25519 -C "muzaalel@gmail.com" -f ~/.ssh/id_welchcenter
echo "Please manually add the above SSH public key to your GitHub account's SSH keys."
read -p "Once you have added the SSH key to your GitHub account, press Enter to continue..."
cat ~/.ssh/id_welchcenter.pub
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_welchcenter

# Build the book with Jupyter Book
jb build welch
git clone "https://github.com/muzaale/center"
cp -r welch/* center
cd center
git add ./*
git commit -m "hardcoded work/abikesa_key.sh; next: make user-driven"
chmod 600 ~/.ssh/id_welchcenter

# Configure the remote URL with SSH
git remote set-url origin "git@github.com:muzaale/center"

# Push changes
git push -u origin main
ghp-import -n -p -f _build/html
rm -rf got
echo "Jupyter Book content updated and pushed to abikesa/got repository!"

