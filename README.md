# dotfiles

个人开发环境配置文件，通过 `setup.sh` 一键部署。

## 包含配置

| 工具 | 配置文件 | 说明 |
|------|----------|------|
| Zsh | `zsh/.zshrc` | vi 模式、fzf/mise/yazi 集成 |
| Bash | `bash/.bashrc` | vi 模式、fzf/yazi 集成 |
| Neovim | `nvim/` | Lua 配置，lazy.nvim 插件管理 |
| Vim | `vim/.vimrc` | 精简配置，vim-plug 插件管理 |
| Tmux | `tmux/.tmux.conf` | Ctrl-s 前缀，vim 风格操作，Gruvbox 配色 |
| Git | `git/.gitconfig` | nvim 作为编辑器/diff 工具，常用别名 |
| Fastfetch | `fastfetch/config.jsonc` | 自定义系统信息展示 |
| SSH | `.ssh/config` | GitHub SSH 连接配置 |

## 安装

```bash
git clone git@github.com:huzch/dotfiles.git
cd dotfiles
./setup.sh
```

脚本支持交互式选择要部署的模块，每个模块可选择**软链接**（默认）或**拷贝**方式部署。

## Neovim 插件

**编码增强** — treesitter（语法高亮）、autopairs、surround、markview（Markdown 预览）

**UI** — catppuccin 主题、lualine 状态栏、yazi 文件管理、which-key 快捷键提示、toggleterm 浮动终端

**搜索移动** — fzf-lua（`Ctrl-P`）、flash.nvim（`s` 快速跳转）

**LSP/补全** — mason 自动安装 LSP（gopls / ts_ls / basedpyright / clangd / rust_analyzer），blink.cmp 补全引擎

## 依赖工具

- [Neovim](https://neovim.io/) (>= 0.11)
- [Tmux](https://github.com/tmux/tmux)
- [fzf](https://github.com/junegunn/fzf)
- [yazi](https://github.com/sxyazi/yazi)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [mise](https://mise.jdx.dev/)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
