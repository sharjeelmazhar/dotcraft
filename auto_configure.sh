#!/bin/bash

set -e

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

echo "Detected distro: $DISTRO"

# Define package manager and update command based on distro
case "$DISTRO" in
    arch)
        PKG_MANAGER="sudo pacman -S --noconfirm --needed"
        UPDATE_CMD="sudo pacman -Sy --noconfirm"
        FONT_PACKAGE="ttf-cascadia-code-nerd"
        # Package names for Arch
        PACKAGES=(
            "fzf"
            "lsd"
            "zoxide"
            "git"
            "zsh"
            "xclip"
            "ripgrep"
            "nodejs"
            "npm"
            "bat"
            "kitty"
            "tmux"
            "neovim"
            "stow"
            "fastfetch"
        )
        ;;
    fedora)
        PKG_MANAGER="sudo dnf install -y"
        UPDATE_CMD="sudo dnf update -y"
        FONT_PACKAGE="cascadia-code-nf-fonts"
        # Package names for Fedora
        PACKAGES=(
            "fzf"
            "lsd"
            "zoxide"
            "git"
            "zsh"
            "xclip"
            "ripgrep"
            "nodejs"
            "npm"
            "bat"
            "kitty"
            "tmux"
            "neovim"
            "stow"
            "fastfetch"
        )
        ;;
    ubuntu)
        PKG_MANAGER="sudo apt install -y"
        UPDATE_CMD="sudo apt update"
        FONT_PACKAGE=""
        # Package names for Ubuntu
        PACKAGES=(
            "fzf"
            "git"
            "zsh"
            "xclip"
            "ripgrep"
            "nodejs"
            "npm"
            "tmux"
            "neovim"
            "zoxide"
            "bat"
            "stow"
            # 'lsd' is not available in default repositories; handled separately
            "kitty"
            "fastfetch"
        )
        ;;
    *)
        echo "Unsupported distribution: $DISTRO"
        exit 1
        ;;
esac

# Function to add PPAs on Ubuntu
add_ubuntu_ppas() {
    echo "Adding necessary PPAs..."
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo add-apt-repository ppa:aslatter/ppa -y  # For lsd
    sudo add-apt-repository ppa:kovidgoyal/kitty -y
    $UPDATE_CMD
}

if [ "$DISTRO" == "ubuntu" ]; then
    add_ubuntu_ppas
fi

# Update package lists
echo "Updating package lists..."
$UPDATE_CMD

# Install packages
echo "Installing packages..."
for package in "${PACKAGES[@]}"; do
    case "$DISTRO" in
        ubuntu)
            case "$package" in
                bat)
                    echo "Installing bat..."
                    $PKG_MANAGER bat

                    # Create an alias for bat
                    if [ ! -f /usr/local/bin/bat ]; then
                        sudo ln -s /usr/bin/batcat /usr/local/bin/bat
                    fi

                    echo "Alias 'bat' created for 'batcat'"
                    ;;
                kitty)
                    echo "Installing kitty..."
                    $PKG_MANAGER kitty
                    ;;
                lsd)
                    echo "Installing lsd..."
                    $PKG_MANAGER lsd
                    ;;
                *)
                    echo "Installing $package..."
                    $PKG_MANAGER $package
                    ;;
            esac
            ;;
        *)
            echo "Installing $package..."
            $PKG_MANAGER $package
            ;;
    esac
done

# Install Cascadia Code Nerd Font
if [ -n "$FONT_PACKAGE" ]; then
    echo "Installing font package: $FONT_PACKAGE"
    $PKG_MANAGER $FONT_PACKAGE
else
    echo "Font package not available via package manager. Installing Cascadia Code Nerd Font manually..."

    FONTS_DIR="$HOME/.fonts"
    mkdir -p "$FONTS_DIR"

    # Download the font files
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip"
    wget -O "$FONTS_DIR/CascadiaCode.zip" "$FONT_URL"

    # Verify the download
    if [ ! -f "$FONTS_DIR/CascadiaCode.zip" ]; then
        echo "Failed to download Cascadia Code font."
        exit 1
    fi

    # Unzip the font files
    unzip -o "$FONTS_DIR/CascadiaCode.zip" -d "$FONTS_DIR"

    # Remove the zip file
    rm "$FONTS_DIR/CascadiaCode.zip"

    # Refresh font cache
    sudo fc-cache -fv

    echo "Fonts installed."
fi

# Change directory to ~/dotfiles and run 'stow .'
DOTFILES_DIR="$HOME/dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    echo "Changing directory to $DOTFILES_DIR"
    cd "$DOTFILES_DIR"

    echo "Running 'stow .' to create symbolic links..."
    stow zshrc kitty nvim tmux fastfetch tmuxifier

    echo "Dotfiles have been stowed successfully."
else
    echo "Directory $DOTFILES_DIR does not exist"
    exit 1
fi

# Install Tmux Plugin Manager (tpm)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    echo "Cloning Tmux Plugin Manager to $TPM_DIR"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "Tmux Plugin Manager already installed at $TPM_DIR"
fi

echo "Setup complete."
