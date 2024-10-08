fastfetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -f "/home/sharjeelm/anaconda3/bin/conda" ]; then
    eval "$(/home/sharjeelm/anaconda3/bin/conda shell.zsh hook)"
fi
# <<< conda initialize <<<
export LIBVIRT_DEFAULT_URI='qemu:///system'

export EDITOR='nvim'
export VISUAL='nvim'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='lsd'
alias c='clear'

# Shell integrations
# Check if the system is not Ubuntu
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" != "ubuntu" ]; then
        # For non-Ubuntu systems
        eval "$(fzf --zsh)"
    fi
else
    # If /etc/os-release is not found, assume non-Ubuntu
    eval "$(fzf --zsh)"
fi
eval "$(zoxide init --cmd cd zsh)"

# setting up tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"


eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/github_sm > /dev/null 2>&1

# alias fnr='cat .zsh_history | fzf | xargs -I {} zsh -c {}'
alias fnr='cat ~/.zsh_history | sed "s/^: [0-9]*:[0-9]*;//" | fzf | xargs -I {} zsh -c {}'


# Function to set Snap path if on Ubuntu
set_snap_path() {
    # Check if the OS is Ubuntu
    if [[ "$OSTYPE" == "linux-gnu" ]] && grep -q "Ubuntu" /etc/os-release; then
        # echo "Detected Ubuntu. Setting up Snap path."
        # Add Snap to PATH
        export PATH="$PATH:/snap/bin"
        # echo "Snap path set: $PATH"
    else
        # echo "Not Ubuntu. No action required."
    fi
}

# Call the function when the terminal opens
set_snap_path
