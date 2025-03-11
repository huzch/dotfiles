#!/bin/bash

# 符号链接，覆盖配置文件
ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc && echo "Linked bash"
ln -sf ~/dotfiles/fastfetch ~/.config && echo "Linked fastfetch"
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc && echo "Linked vim"
ln -sf ~/dotfiles/nvim ~/.config && echo "Linked nvim"
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf && echo "Linked tmux"
ln -sf ~/dotfiles/yazi ~/.config && echo "Linked yazi"
ln -sf ~/dotfiles/lazygit ~/.config && echo "Linked lazygit"
ln -sf ~/dotfiles/gdb/.gdbinit ~/.gdbinit && echo "Linked gdb"
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig && echo "Linked git"
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config && echo "Linked ssh"

# 将仓库设置为 SSH 连接
git remote set-url origin git@github.com:huzch/dotfiles.git && echo "Set Git remote to SSH URL."

# 检查是否存在 SSH 密钥文件 id_ed25519
SSH_KEY="$HOME/.ssh/id_ed25519"

if [ -f "$SSH_KEY" ]; then
    echo "SSH key '$SSH_KEY' already exists."
else
    echo "SSH key '$SSH_KEY' not found. Generating a new SSH key..."
    
    # 检查是否安装了 ssh-keygen
    if ! command -v ssh-keygen &>/dev/null; then
        echo "Error: 'ssh-keygen' command not found. Please install OpenSSH tools."
        exit 1
    fi

    # 运行 ssh-keygen 生成新的 ed25519 密钥
    ssh-keygen -o -a 100 -t ed25519 -f "$SSH_KEY" -C "huzch123@gmail.com"

    # 检查生成是否成功
    if [ $? -eq 0 ]; then
        echo "SSH key generated successfully: $SSH_KEY"
        chmod 600 "$SSH_KEY"  # 确保密钥文件权限
        eval "$(ssh-agent -s)"  # 启动 ssh-agent
        ssh-add "$SSH_KEY" && echo "SSH key added to ssh-agent."
        echo "Public key:"
        cat "${SSH_KEY}.pub"
    else
        echo "Failed to generate SSH key. Please check your configuration."
        exit 1
    fi
fi
