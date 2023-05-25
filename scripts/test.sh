#!/bin/bash

docker run --rm \
    -v ${PWD}:/home/user/dotfiles \
    -u user \
    -e HOME=/home/user \
    dotfiles:latest \
    bash -c "./tests/setup_test.sh"