
#========= Basic =========

# 如果不是交互式 shell，直接返回
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth #不在历史记录中添加重复行或以空格开头的命令

shopt -s histappend #将命令追加到历史文件而不是覆盖

# 设置历史记录的大小
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize #自动检测窗口大小并更新

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" #使less智能处理各种文本文件

# 启用命令补全功能
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

set -o vi #开启vim模式




# ========= Prompt =========

# 判断终端是否支持颜色
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# 设置 PS1（提示符样式）
if [ "$color_prompt" = yes ]; then
    PS1='
\[\033[38;5;245m\]\w\[\033[00m\]
\[\033[38;5;75m\]➜ \[\033[00m\]'  # 第一行显示路径，第二行显示箭头
else
    PS1='
\w
➜ '
fi
unset color_prompt 

# 显示系统信息
clear
if command -v fastfetch &> /dev/null
then
    fastfetch
fi




# ========= Alias =========

# 启用 ls 的颜色支持以及其他常用命令的别名
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls 的额外别名
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias c='clear'
alias x='startx'
alias lg='lazygit'
alias ff='fastfetch'
alias sl='slock'
alias dl='dm-tool lock'



# ========= Environment =========

# export PATH="$PATH:~/.local/share/nvim/lazy/fzf/bin"
eval "$(fzf --bash)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export EDITOR="nvim"
export VISUAL="nvim"




# ========= Function =========

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
