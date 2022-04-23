#!/bin/bash

# Automatic setup of bash, git  and other config in a linux machine

echo "Configuring environment"

echo "Copying .bash_config"
cp -bf bash_config ~/.bash_config

echo "Copying .bash_local"
# We won't replace bash_local since default one is empty
if [ -f ~/.bash_local ]; then
    echo ".bash_local already present. Not replacing."
else
    cp bash_local ~/.bash_local
fi

# VIM configuration
echo "Configuring vim"
cp -bf vimrc ~/.vimrc

echo "Installing vscode color palette for vim"
if [ -f ~/.vim/colors ]; then
    echo "~/.vim/colors already exists."
else
    mkdir -p ~/.vim/colors
fi
curl -O https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim
cp -f codedark.vim ~/.vim/colors/codedark.vim

# Custom path folder
echo "Creating custom folder for adding custom items to PATH ~/.others"
if [ -f ~/.others ]; then
    echo "~/.others already exists."
else
	mkdir ~/.others
fi

# Git configuration
echo "Configuring git: .gitconfig, global .gitignore and commit-template"
cp -bf git/commit-template.txt ~/.others
cp -bf git/gitconfig ~/.gitconfig
touch ~/.others/.gitingore

echo "Installing diff-so-fancy for improving diffs"
curl -O https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
cp -f diff-so-fancy ~/.others/diff-so-fancy
chmod +x ~/.others/diff-so-fancy

echo "Enter your git user:"
echo "Username: (between \" \")"
read user
echo "Email:"
echo "If you're configuring Github email follow his format: username@users.noreply.github.com"
read mail

git config --global user.name $user
git config --global user.email $mail

echo "Git config done"

echo "Including .bash_config at the end of .bashrc for non invasive configuration"
echo "
if [ -f ~/.bash_config ]; then
    . ~/.bash_config
fi" >> ~/.bashrc

echo "Saving installation_log.txt"
HASH=$(git rev-parse HEAD)
echo $HASH >> installation_log.txt
echo "Configuration done, configuration commit hash: $HASH"
