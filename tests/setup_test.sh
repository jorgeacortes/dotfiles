#!/bin/bash

# Launch the setup with git config input
{ echo user & sleep 0.1; echo user@example.com; } | source setup.sh

# Verify stuff

ls -la /home/user
ls -la /home/user/.others

cat /home/user/.gitconfig | grep "name = user"
test $? -eq 0 || echo "User not configured" && exit 1

cat /home/user/.gitconfig | grep "email"
test $? -eq 0 || echo "User not configured" && exit 1

# /bin/bash -c "echo $PATH"
# /bin/bash -c "echo $(whoami)"
# /bin/bash -c "which diff-so-fancy"

exit 0