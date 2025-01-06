
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

# 识别chroot环境信息
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# 判断终端是否支持颜色
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# 设置 PS1（提示符样式）
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt 

# 如果是 xterm，设置窗口标题
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

alias lg='lazygit'

alias edge='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'

alias steam='/mnt/d/Steam/steam.exe'


# ========= Environment =========

export PATH="$PATH:~/.local/share/nvim/lazy/fzf/bin"
eval "$(fzf --bash)"

export EDITOR="nvim"
export VISUAL="nvim"



[ -f ~/.fzf.bash ] && source ~/.fzf.bash




# ========= Function =========

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
