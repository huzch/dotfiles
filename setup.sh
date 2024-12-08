#!/bin/bash

# 符号链接，覆盖配置文件
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

