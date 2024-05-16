# Fork/clone then create SSH key

jb build quick
ls -al ~/.ssh
ssh-keygen -t ed25519 -C "abikesa.sh@gmail.com.com" -f ~/.ssh/id_gpt4omni
echo "Please manually add the above SSH public key to your GitHub account's SSH keys."
read -p "Once you have added the SSH key to your GitHub account, press Enter to continue..."
cat ~/.ssh/id_gpt4omni.pub
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_gpt4omni

# Build the book with Jupyter Book
jb build gpt4
git clone "https://github.com/abikesa/omni"
cp -r gpt4/* omni
cd omni
git add ./*
git commit -m "gpt4-o, thank you!"
chmod 600 ~/.ssh/id_gpt4omni

# Configure the remote URL with SSH
git remote set-url origin "git@github.com:abikesa/omni"

# Push changes
git push -u origin main
ghp-import -n -p -f _build/html
cd ..
rm -rf deploy
echo "Jupyter Book content updated and pushed to abikesa/got repository!"



# commitment issues!!

```bash
(myenv) d@Poseidon project % git add ./*
(myenv) d@Poseidon project % git commit -m "zero jb"
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    _config.yml
        deleted:    _toc.yml
        deleted:    intro.md
        deleted:    logo.png
        deleted:    markdown-notebooks.md
        deleted:    markdown.md
        deleted:    notebooks.ipynb
        deleted:    references.bib
        deleted:    requirements.txt
        deleted:    stmarkdown.css.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .DS_Store

no changes added to commit (use "git add" and/or "git commit -a")
(myenv) d@Poseidon project % git rm  _config.yml
rm '_config.yml'
(myenv) d@Poseidon project % git rm   _toc.yml intro.md
rm '_toc.yml'
rm 'intro.md'
(myenv) d@Poseidon project % git rm logo.png markdown-notebooks.md markdown.md notebooks.ipynb references.bib requirements.txt stmarkdown.css.txt
rm 'logo.png'
rm 'markdown-notebooks.md'
rm 'markdown.md'
rm 'notebooks.ipynb'
rm 'references.bib'
rm 'requirements.txt'
rm 'stmarkdown.css.txt'
(myenv) d@Poseidon project % git add ./*
(myenv) d@Poseidon project % git commit -m "no jb"
[main 217e24c] no jb
 10 files changed, 485 deletions(-)
 delete mode 100644 _config.yml
 delete mode 100644 _toc.yml
 delete mode 100644 intro.md
 delete mode 100644 logo.png
 delete mode 100644 markdown-notebooks.md
 delete mode 100644 markdown.md
 delete mode 100644 notebooks.ipynb
 delete mode 100644 references.bib
 delete mode 100644 requirements.txt
 delete mode 100644 stmarkdown.css.txt
(myenv) d@Poseidon project % chmod 600 ~/.ssh/id_intermediateproject
(myenv) d@Poseidon project % git remote set-url origin "git@github.com:jhustata/project"
(myenv) d@Poseidon project % git push -u origin main
To github.com:jhustata/project
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'github.com:jhustata/project'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
(myenv) d@Poseidon project % git pull
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 3 (delta 1), reused 1 (delta 1), pack-reused 2
Unpacking objects: 100% (3/3), 1.67 KiB | 568.00 KiB/s, done.
From github.com:jhustata/project
   db503bf..3d0675b  main       -> origin/main
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint: 
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint: 
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.
(myenv) d@Poseidon project % git config pull.rebase true 
(myenv) d@Poseidon project % git pull                    
Successfully rebased and updated refs/heads/main.
(myenv) d@Poseidon project % git push -u origin main     
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 20 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 230 bytes | 230.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To github.com:jhustata/project
   3d0675b..20ff4e7  main -> main
branch 'main' set up to track 'origin/main'.
(myenv) d@Poseidon project % 
```