PROMPT='
%F{245}%~%f
%F{75}➜ %f'

set -o vi

alias c='clear'
alias cc='claude'
alias lg='lazygit'
alias ff='fastfetch'

export EDITOR="nvim"
export VISUAL="nvim"
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
eval "$(fzf --zsh)"
export PATH=$HOME/.local/bin:$PATH
eval "$(mise activate zsh)"

export ANTHROPIC_BASE_URL="https://openrouter.ai/api" 		 # Anthropic 兼容端点
export ANTHROPIC_AUTH_TOKEN="sk-or-v1-xxx"                   # 替换为您的 API Key
export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC="1"          # 禁用非必要流量
export API_TIMEOUT_MS="30000000"                             # API 超时时间（毫秒）
export ANTHROPIC_API_KEY="" 								 # 避免回退官方认证
export ANTHROPIC_DEFAULT_OPUS_MODEL="anthropic/claude-opus-4-6"
export ANTHROPIC_DEFAULT_SONNET_MODEL="anthropic/claude-sonnet-4-6"
export ANTHROPIC_DEFAULT_HAIKU_MODEL="anthropic/claude-haiku-4-5"
export CLAUDE_CODE_SUBAGENT_MODEL="anthropic/claude-opus-4-6"

clear

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
