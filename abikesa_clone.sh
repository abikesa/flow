# Ensure your SSH agent is running:
eval "$(ssh-agent -s)"

# And that your key is added:
ssh-add ~/.ssh/id_rsa

# Test SSH Connection: Test your SSH connection to GitHub:
ssh -T git@github.com

# Clone your private repo
git clone git@github.com:jhurepos/projectalpha.git
