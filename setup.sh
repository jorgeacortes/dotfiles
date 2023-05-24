#!/bin/bash

# Automatic setup of bash, git  and other config in a linux machine

echo "Configuring environment"
INSTALL_FOLDER=${HOME}/.others

echo "Copying .bash_config"
cp -bf bash_config ${HOME}/.bash_config

echo "Copying .bash_local"
# We won't replace bash_local since default one is empty
if [ -f ${HOME}/.bash_local ]; then
    echo ".bash_local already present. Not replacing."
else
    cp bash_local ${HOME}/.bash_local
fi

# VIM configuration
echo "Configuring vim"
cp -bf vimrc ${HOME}/.vimrc

echo "Installing vscode color palette for vim"
if [ -f ${HOME}/.vim/colors ]; then
    echo "${HOME}/.vim/colors already exists."
else
    mkdir -p ${HOME}/.vim/colors
fi
curl -O https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim
cp -f codedark.vim ${HOME}/.vim/colors/codedark.vim

# Custom path folder
echo "Creating custom folder for adding custom items to PATH ${INSTALL_FOLDER}"
if [ -f ${INSTALL_FOLDER} ]; then
    echo "${INSTALL_FOLDER} already exists."
else
	mkdir ${INSTALL_FOLDER}
fi

# Git configuration
GITHOOKS_FOLDER=${INSTALL_FOLDER}/githooks
echo "Creating githooks folder at ${GITHOOKS_FOLDER}"
if [ -f ${GITHOOKS_FOLDER} ]; then
    echo "${GITHOOKS_FOLDER} already exists."
else
	mkdir ${GITHOOKS_FOLDER}
fi

echo "Copying global git hooks"
cp -bf git/pre-push ${GITHOOKS_FOLDER}
cp -bf git/pre-commit ${GITHOOKS_FOLDER}
cp -bf git/common.sh ${GITHOOKS_FOLDER}
chmod +x ${GITHOOKS_FOLDER}/pre-push
chmod +x ${GITHOOKS_FOLDER}/pre-commit
chmod +x ${GITHOOKS_FOLDER}/common.sh

echo "Configuring git: .gitconfig, global .gitignore and commit-template"
cp -bf git/commit-template.txt ${INSTALL_FOLDER}
cp -bf git/gitconfig ${HOME}/.gitconfig
# Empty for now
cp -bf git/gitignore ${INSTALL_FOLDER}/.gitignore

echo "Installing diff-so-fancy for improving diffs"
curl -O https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
cp -f diff-so-fancy ${INSTALL_FOLDER}/diff-so-fancy
chmod +x ${INSTALL_FOLDER}/diff-so-fancy

echo "Enter your git user:"
echo "Username: (between \" \")"
read user
echo "Email:"
echo "If you're configuring Github email follow his format: username@users.noreply.github.com"
read mail

git config --global user.name $user
git config --global user.email $mail

echo "Git config done"

# Bash config
echo "Including .bash_config at the end of .bashrc for non invasive configuration"
echo "
if [ -f ${HOME}/.bash_config ]; then
    . ${HOME}/.bash_config
fi" >> ${HOME}/.bashrc

# Log
echo "Saving installation_log.txt"
HASH=$(git rev-parse HEAD)
echo $HASH >> installation_log.txt
echo "Configuration done, configuration commit hash: $HASH"
