#!/usr/bin/env bash

set -euo pipefail

info() { printf "[INFO] %s\n" "$*"; }
warn() { printf "[WARN] %s\n" "$*" >&2; }
die() { printf "[ERROR] %s\n" "$*" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

ensure_parent_dir() {
  local dst="$1"
  local parent
  parent="$(dirname "$dst")"
  mkdir -p "$parent"
}

rm_existing_dst() {
  local dst="$1"
  if [ -L "$dst" ] || [ -f "$dst" ]; then
    rm -f "$dst"
  elif [ -d "$dst" ]; then
    rm -rf "$dst"
  fi
}

do_link() {
  local src="$1"
  local dst="$2"

  [ -e "$src" ] || die "源路径不存在：$src"
  ensure_parent_dir "$dst"
  rm_existing_dst "$dst"
  ln -sfn "$src" "$dst"
}

do_copy() {
  local src="$1"
  local dst="$2"

  [ -e "$src" ] || die "源路径不存在：$src"
  ensure_parent_dir "$dst"
  rm_existing_dst "$dst"

  if [ -d "$src" ]; then
    # 兼容 macOS/BSD：优先用 -a，不支持时回退到 -R
    if cp -a "$src" "$dst" 2>/dev/null; then
      :
    else
      cp -R "$src" "$dst"
    fi
  else
    cp -f "$src" "$dst"
  fi
}

set_git_remote_to_ssh() {
  local repo="$1"
  local url="git@github.com:huzch/dotfiles.git"

  command -v git >/dev/null 2>&1 || { warn "未找到 git，跳过设置 remote"; return 0; }
  if [ ! -d "$repo/.git" ]; then
    warn "当前目录不是 git 仓库（$repo），跳过设置 remote"
    return 0
  fi

  git -C "$repo" remote set-url origin "$url"
  info "已将 dotfiles 仓库 origin 设置为 SSH：$url"
}

ensure_ssh_key() {
  local ssh_key="$HOME/.ssh/id_ed25519"

  if [ -f "$ssh_key" ]; then
    info "SSH key 已存在：$ssh_key"
    return 0
  fi

  command -v ssh-keygen >/dev/null 2>&1 || die "未找到 ssh-keygen，请先安装 OpenSSH 工具"
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh" || true

  info "未找到 SSH key，开始生成：$ssh_key"
  # 默认不设置口令，避免脚本卡在交互输入
  ssh-keygen -o -a 100 -t ed25519 -f "$ssh_key" -C "huzch123@gmail.com" -N ""

  chmod 600 "$ssh_key" || true
  # 尝试加入 ssh-agent（失败不阻塞；非交互环境跳过）
  if is_interactive && command -v ssh-agent >/dev/null 2>&1 && command -v ssh-add >/dev/null 2>&1; then
    eval "$(ssh-agent -s 2>/dev/null)" >/dev/null 2>&1 || true
    ssh-add "$ssh_key" >/dev/null 2>&1 || true
  fi

  info "Public key："
  cat "${ssh_key}.pub"
}

is_interactive() {
  [ -t 0 ] && [ -t 1 ]
}

prompt_select_modules() {
  local count="$1"
  local out_var="$2"
  local input

  while true; do
    printf "\n请选择要初始化的模块（输入编号，逗号分隔；a=全选；q=退出）：\n"
    if ! IFS= read -r -p "> " input; then
      # Ctrl-D / EOF
      exit 0
    fi
    input="${input//[[:space:]]/}"

    if [ -z "$input" ]; then
      warn "未选择任何模块"
      continue
    fi
    if [ "$input" = "q" ] || [ "$input" = "quit" ]; then
      exit 0
    fi
    if [ "$input" = "a" ] || [ "$input" = "all" ]; then
      local all=""
      local i
      for i in $(seq 1 "$count"); do
        all+="$i,"
      done
      printf -v "$out_var" "%s" "${all%,}"
      return 0
    fi

    # 简单校验：只能包含数字和逗号
    if [[ ! "$input" =~ ^[0-9,]+$ ]]; then
      warn "输入格式不正确：$input"
      continue
    fi

    printf -v "$out_var" "%s" "$input"
    return 0
  done
}

prompt_mode_for_module() {
  local label="$1"
  local out_var="$2"
  local ans
  while true; do
    read -r -p "为【${label}】选择方式：1) 软链接  2) 拷贝  [1]：" ans
    ans="${ans:-1}"
    case "$ans" in
      1|l|L|link|ln) printf -v "$out_var" "%s" "link"; return 0 ;;
      2|c|C|copy|cp) printf -v "$out_var" "%s" "copy"; return 0 ;;
      *) warn "无效输入：$ans" ;;
    esac
  done
}

main() {
  # 模块定义（避免依赖 bash 4 的 associative array；兼容 macOS 默认 bash 3.2）
  local labels=()
  local kinds=()
  local srcs=()
  local dsts=()

  labels+=("bash -> ~/.bashrc")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/bash/.bashrc")
  dsts+=("$HOME/.bashrc")

  labels+=("fastfetch -> ~/.config/fastfetch")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/fastfetch")
  dsts+=("$HOME/.config/fastfetch")

  labels+=("git -> ~/.gitconfig")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/git/.gitconfig")
  dsts+=("$HOME/.gitconfig")

  labels+=("nvim -> ~/.config/nvim")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/nvim")
  dsts+=("$HOME/.config/nvim")

  labels+=("tmux -> ~/.tmux.conf")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/tmux/.tmux.conf")
  dsts+=("$HOME/.tmux.conf")

  labels+=("vim -> ~/.vimrc")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/vim/.vimrc")
  dsts+=("$HOME/.vimrc")

  labels+=("ssh config -> ~/.ssh/config")
  kinds+=("linkable")
  srcs+=("$DOTFILES_DIR/.ssh/config")
  dsts+=("$HOME/.ssh/config")

  labels+=("git remote: origin -> SSH")
  kinds+=("git_remote")
  srcs+=("")
  dsts+=("")

  labels+=("生成 SSH key（id_ed25519）")
  kinds+=("ssh_key")
  srcs+=("")
  dsts+=("")

  local total="${#labels[@]}"
  info "dotfiles 目录：$DOTFILES_DIR"

  local selection=""
  if is_interactive; then
    local i
    printf "\n可初始化的模块：\n"
    for i in "${!labels[@]}"; do
      printf "%2d) %s\n" $((i + 1)) "${labels[i]}"
    done
    prompt_select_modules "$total" selection
  else
    # 非交互环境：保持旧行为（全选 + 软链接）
    local all=""
    local i
    for i in $(seq 1 "$total"); do all+="$i,"; done
    selection="${all%,}"
  fi

  if [ -z "$selection" ]; then
    warn "未选择任何模块，退出"
    exit 0
  fi

  local picks=()
  IFS=',' read -r -a picks <<<"$selection"
  local seen=""
  local pick

  for pick in "${picks[@]:-}"; do
    [ -n "$pick" ] || continue
    # 去重
    if [[ " $seen " == *" $pick "* ]]; then
      continue
    fi
    seen+=" $pick "

    if [[ ! "$pick" =~ ^[0-9]+$ ]]; then
      warn "跳过无效编号：$pick"
      continue
    fi
    if [ "$pick" -lt 1 ] || [ "$pick" -gt "$total" ]; then
      warn "跳过越界编号：$pick"
      continue
    fi

    local idx=$((pick - 1))
    local label="${labels[idx]}"
    local kind="${kinds[idx]}"

    case "$kind" in
      linkable)
        local src="${srcs[idx]}"
        local dst="${dsts[idx]}"

        # ssh 目录需要先创建
        if [[ "$dst" == "$HOME/.ssh/"* ]]; then
          mkdir -p "$HOME/.ssh"
          chmod 700 "$HOME/.ssh" || true
        fi
        if [[ "$dst" == "$HOME/.config/"* ]]; then
          mkdir -p "$HOME/.config"
        fi

        local mode="link"
        if is_interactive; then
          prompt_mode_for_module "$label" mode
        fi

        if [ "$mode" = "copy" ]; then
          do_copy "$src" "$dst"
          info "已拷贝：$label"
        else
          do_link "$src" "$dst"
          info "已软链接：$label"
        fi
        ;;
      git_remote)
        set_git_remote_to_ssh "$DOTFILES_DIR"
        ;;
      ssh_key)
        ensure_ssh_key
        ;;
      *)
        warn "未知模块类型：${kind}（${label}）"
        ;;
    esac
  done
}

main "$@"
