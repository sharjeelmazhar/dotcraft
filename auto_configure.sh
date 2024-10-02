#!/bin/bash

set -e

# Color definitions for output
GREEN='\033[0;32m'
NC='\033[0m' # No color

# Function to print success messages in green
print_success() {
    echo -e "${GREEN}$1${NC}"
}

# Error handler function
error_exit() {
    echo "Error on line $1: $2"
    exit 1
}

trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

# Detect the distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot determine Linux distribution."
    exit 1
fi

print_success "Detected distro: $DISTRO"

# Package installation for Arch, Fedora, and Ubuntu
install_packages() {
    case "$DISTRO" in
        arch)
            PKG_MANAGER="sudo pacman -S --noconfirm --needed"
            UPDATE_CMD="sudo pacman -Sy --noconfirm"
            FONT_PACKAGE="ttf-cascadia-code-nerd"
            PACKAGES=("fzf" "lsd" "zoxide" "git" "zsh" "xclip" "ripgrep" "nodejs" "npm" "bat" "kitty" "tmux" "stow" "fastfetch" "neovim" "$FONT_PACKAGE")
            ;;
        fedora)
            PKG_MANAGER="sudo dnf install -y"
            UPDATE_CMD="sudo dnf update -y"
            FONT_PACKAGE="cascadia-code-nf-fonts"
            PACKAGES=("fzf" "lsd" "zoxide" "git" "zsh" "xclip" "ripgrep" "nodejs" "npm" "bat" "kitty" "tmux" "stow" "fastfetch" "neovim" "$FONT_PACKAGE")
            ;;
        ubuntu)
            PKG_MANAGER="sudo apt install -y"
            UPDATE_CMD="sudo apt update"
            PACKAGES=("fzf" "lsd" "zoxide" "git" "zsh" "xclip" "ripgrep" "nodejs" "npm" "bat" "kitty" "tmux" "stow")

            print_success "Adding necessary PPAs for Ubuntu..."
            sudo apt install -y software-properties-common
            sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y  # PPA for fastfetch
            $UPDATE_CMD
            PACKAGES+=("fastfetch")
            ;;
        *)
            echo "Unsupported distribution: $DISTRO"
            exit 1
            ;;
    esac

    print_success "Updating package lists..."
    $UPDATE_CMD

    print_success "Installing packages..."
    for package in "${PACKAGES[@]}"; do
        print_success "Installing $package..."
        $PKG_MANAGER $package
    done
}

# Special Neovim setup for Ubuntu
install_neovim_ubuntu() {
    print_success "Installing the latest Neovim on Ubuntu..."
    
    # Download the latest Neovim release
    wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

    # Extract the tarball to /tmp
    sudo tar xzf nvim-linux64.tar.gz -C /tmp

    # Copy necessary files to /usr/local/share
    sudo cp -r /tmp/nvim-linux64/share/nvim /usr/local/share/

    # Move the nvim binary to /usr/bin
    sudo mv /tmp/nvim-linux64/bin/nvim /usr/bin/nvim

    # Clean up the downloaded tarball and extracted files
    rm nvim-linux64.tar.gz
    sudo rm -rf /tmp/nvim-linux64

    print_success "Neovim installed successfully."
}

# Install Cascadia Code Nerd Font for Ubuntu
install_font_ubuntu() {
    print_success "Installing Cascadia Code Nerd Font on Ubuntu..."

    # Download the Cascadia Code Nerd Font
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip -O /tmp/CascadiaCode.zip

    # Create fonts directory if it doesn't exist
    mkdir -p "$HOME/.fonts"

    # Unzip the font files to the fonts directory
    unzip -o /tmp/CascadiaCode.zip -d "$HOME/.fonts"

    # Refresh the font cache
    sudo fc-cache -fv

    # Clean up the downloaded zip file
    rm /tmp/CascadiaCode.zip

    print_success "Cascadia Code Nerd Font installed successfully."
}

# Backup and stow configurations
stow_configs() {
    DOTFILES_DIR="$HOME/dotcraft"
    declare -A CONFIG_PATHS=(
        ["zshrc"]="$HOME/.zshrc"
        ["kitty"]="$HOME/.config/kitty"
        ["nvim"]="$HOME/.config/nvim"
        ["tmux"]="$HOME/.tmux.conf"
        ["fastfetch"]="$HOME/.config/fastfetch"
        ["tmuxifier"]="$HOME/.tmuxifier"
    )

    if [ -d "$DOTFILES_DIR" ]; then
        print_success "Changing directory to $DOTFILES_DIR"
        cd "$DOTFILES_DIR"

        for config in "${!CONFIG_PATHS[@]}"; do
            CONFIG_PATH="${CONFIG_PATHS[$config]}"
            if [ -e "$CONFIG_PATH" ]; then
                print_success "Backing up existing $CONFIG_PATH to $CONFIG_PATH.bak"
                mv "$CONFIG_PATH" "$CONFIG_PATH.bak"
            fi
        done

        print_success "Running 'stow' to create symbolic links..."
        stow zshrc kitty nvim tmux fastfetch tmuxifier

        print_success "Dotfiles have been stowed successfully."
    else
        echo "Directory $DOTFILES_DIR does not exist"
        exit 1
    fi
}

# Install Tmux Plugin Manager (tpm)
install_tpm() {
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        print_success "Cloning Tmux Plugin Manager to $TPM_DIR"
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" || print_success "TPM is already installed."
    else
        print_success "Tmux Plugin Manager already installed at $TPM_DIR"
    fi
}

# Change the default shell to zsh
change_shell_to_zsh() {
    print_success "Changing default shell to zsh..."
    chsh -s $(which zsh)
}

# Install packages
install_packages

# If Ubuntu, handle special installations
if [ "$DISTRO" == "ubuntu" ]; then
    install_neovim_ubuntu
    install_font_ubuntu
fi

# Backup and stow dotfiles
stow_configs

# Install Tmux Plugin Manager
install_tpm

# Change default shell to zsh
change_shell_to_zsh

print_success "Setup complete."
