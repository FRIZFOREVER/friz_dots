# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Tools
source <(fzf --zsh)

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Editors
export VISUAL="nvim"
export EDITOR="nvim"

# Paths
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/lib/npm/bin:$PATH:$HOME/.spicetify"

# File navigation and display
alias ls='eza --group-directories-first --icons'
alias la='eza -A --group-directories-first --icons'
alias ll='eza -lah --group-directories-first --icons'
alias lt='eza --group-directories-first --icons --tree'
alias cat='bat'
alias find='fd'

# Editing
alias vi='nvim'
alias vim='nvim'
alias nv='nvim .'
alias uvjupyter='uv run --with jupyter jupyter lab'

# Git
alias ga='git add .'
alias gc='git commit -m'
alias gf='git fetch origin'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias gw='git switch'

# Development
alias venva='source .venv/bin/activate'
alias dcu='docker compose up --build'
alias dcd='docker compose down'
alias dcud='docker compose up --build --watch'

# Miscellaneous
alias pipes='pipes -t 1 -f 100 -R -p 2'
alias phone='kdeconnect-cli --device 8ca1dc58f3ad404a9a45014279fe079a --share'
alias scrcpy='adb connect 10.173.214.103:5555 >/dev/null 2>&1 && command scrcpy'

# Fastfetch and prompt
[[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1 && fastfetch
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
