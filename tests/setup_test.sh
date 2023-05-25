#!/bin/bash

USER_FOLDER="${HOME:-/home/user}"  

echo "Launching setup.sh"
source setup.sh < <(echo user & sleep 0.1; echo user@example.com;)


echo "Test git configuration"
grep "name = user" $USER_FOLDER/.gitconfig
test $? -eq 0 || { echo "git user not configured"; exit 1; }
grep "email = user@example.com" $USER_FOLDER/.gitconfig
test $? -eq 0 || { echo "git email not configured"; exit 1; }

echo "Test diff so fancy installed"
ls  $USER_FOLDER/.others/diff-so-fancy || { echo "diff-so-fancy not installed"; exit 1; }
