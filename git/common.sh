#!/bin/bash
# Common code for git hooks

# Common variables
GIT_BRANCH=$(git branch --show-current)
GIT_PROJECT_FOLDER=${PWD##*/}

# Exceptions here: add the name of the folders of the git clone to avoid executing global hooks
project_folder_exceptions=(
    ""
)

# Used for hooks to check if the project is in exceptions list
IS_IN_EXCEPTIONS=0

# Check if current project is in exceptions and populate the variable accordingly
if printf '%s\0' "${project_folder_exceptions[@]}" | grep -Fxqz "$GIT_PROJECT_FOLDER"; then
    echo "Hooks: project is in exceptions list"
    IS_IN_EXCEPTIONS=1
fi