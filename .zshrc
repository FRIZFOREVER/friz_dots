# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="wedisagree"

plugins=( 
    git
    dnf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# check the dnf plugins commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dnf


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Set-up icons for files/directories in terminal using lsd
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# --- vi/vim -> nvim ---
alias vi="nvim"
alias vim="nvim"

# --- git ---
alias ga='git add .'
alias gc='git commit -m'
alias gs='git switch'
alias gf='git fetch origin'
alias gl='git pull'
alias gp='git push'
alias gs='git status'

# python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv .venv && source .venv/bin/activate'
alias venva='source .venv/bin/activate'
alias uvi='uv init --no-description --build-backend uv --no-readme --color always --no-pin-python'

# Random stuff
alias pipes='pipes -t 1 -f 100 -R -p 2'
alias ssh-addme='ssh-add "$HOME/.ssh/id_ed25519" && ssh-add -l'

# >>> programming cache paths <<<
# Hugging Face
export HF_HOME="$HOME/programming/models/hf"
export HF_HUB_CACHE="$HF_HOME/hub"
export TRANSFORMERS_CACHE="$HF_HUB_CACHE"
# (Optional legacy) export HUGGINGFACE_HUB_CACHE="$HF_HUB_CACHE"

# PyTorch
export TORCH_HOME="$HOME/programming/models/torch"

# Experiments
export WANDB_DIR="$HOME/programming/experiments/wandb"

# Ollama (CLI sessions only; the systemd service needs a drop-in)
export OLLAMA_MODELS="$HOME/programming/models/ollama"

# Put your personal bin first (zsh-safe path manipulation)
path=("$HOME/programming/bin" $path)
# <<< programming cache paths (zsh) <<<
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ---- SSH agent via keychain (start-only, robust) ----
if [[ $- == *i* ]] && command -v keychain >/dev/null; then
  # Throw away any inherited agent from login managers
  unset SSH_AUTH_SOCK SSH_AGENT_PID

  # Start/reuse a single agent for the user session
  eval "$(keychain --eval --quiet --agents ssh)"

  # Source whichever hostname file keychain created (names can vary)
  for f in "$HOME/.keychain/${HOST%%.*}-sh" \
           "$HOME/.keychain/${HOSTNAME%%.*}-sh" \
           "$HOME/.keychain/$(hostname -s)-sh" \
           "$HOME/.keychain/$(hostname)-sh" \
           "$HOME/.keychain/fedora-sh"; do
    [[ -r "$f" ]] && source "$f" && break
  done
fi
