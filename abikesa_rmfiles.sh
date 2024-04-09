# Tokens: Profile photo, Settings, Developer Settings
# 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
# jhustata/basic

# Delete repo folder
git clone https://token@github.com/abikesa/ssh.git
cd ssh
git checkout main
rm -r ssh*

# Stage the Deletions
git add -A 

# Commit the Deletions
git commit -m "Removed ssh in main directory" 
    
# Push the Deletions
git remote -v
ssh-add -D 
chmod 600 "$(eval echo ~/.ssh/id_sharessh)"
git remote set-url origin "git@github.com:abikesa/ssh"
ssh-add "$(eval echo ~/.ssh/id_sharessh)"
git config --local user.name "abikesa"
git config --local user.email "abikesa.sh@gmail.com"
git push -u origin main




