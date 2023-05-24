FROM ubuntu:22.04

RUN apt-get update \
      && apt-get install -y git curl grep \
      && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash  user
RUN mkdir -p /home/user/dotfiles

WORKDIR /home/user/dotfiles