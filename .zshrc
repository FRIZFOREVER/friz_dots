# fastfetch
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

# Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Gets re-introduced later with starship
ZSH_THEME=""

# Update
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 2

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Plugins on startup
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# editors
export VISUAL="nvim"
export EDITOR="nvim"

# better cd
eval "$(zoxide init zsh)"

# fzf keybindings + completion (Arch path)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# nicer defaults (optional)
alias ls='eza --group-directories-first --icons'
alias la='eza -A --group-directories-first --icons'
alias ll='eza -lah --group-directories-first --icons'
alias lt='eza --group-directories-first --icons --tree'
alias cat='bat'
alias find='fd'

# Editing
alias vi="nvim"
alias vim="nvim"
alias nv="nvim ."

# git
alias ga='git add .'
alias gc='git commit -m'
alias gs='git switch'
alias gf='git fetch origin'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias gw='git switch'

# dev
# alias py='python3'
# alias pip='pip3'
alias venva='source .venv/bin/activate'
alias dcu='docker compose up --build'
alias dcd='docker compose down'
alias dcud='docker compose -f compose.yml -f compose.dev.yml up --build'

# cli showoff
alias pipes='pipes -t 1 -f 100 -R -p 2'

# Reuse one ssh-agent across shells; load GitHub key once per login/boot
eval "$(keychain --quiet --eval ~/.ssh/id_ed25519)"

# History like fish: shared, incremental, no duplicates
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
eval "$(starship init zsh)"

source ~/.config/zshrc.d/auto-Hypr.sh
