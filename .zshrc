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
# Don't spell-correct these words
CORRECT_IGNORE+=' test tests '

typeset -a CORRECT_IGNORE
CORRECT_IGNORE+=(test tests)

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
alias ga='nocorrect git add .'
alias gc='nocorrect git commit -m'
alias gf='nocorrect git fetch origin'
alias gl='nocorrect git pull'
alias gp='nocorrect git push'
alias gs='nocorrect git status'
alias gw='nocorrect git switch'

# dev
# alias py='python3'
# alias pip='pip3'
alias venva='source .venv/bin/activate'
alias dcu='docker compose up --build'
alias dcd='docker compose down'
alias dcud='docker compose up --build --watch'

# npm user directory
export PATH="$HOME/.npm-global/bin:$PATH"

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
