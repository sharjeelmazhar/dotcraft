
#!/bin/bash

set -e

# Color definitions
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to print messages in green
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
            "lsd"
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
    print_success "Adding necessary PPAs..."
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y  # For fastfetch
    $UPDATE_CMD
}

if [ "$DISTRO" == "ubuntu" ]; then
    add_ubuntu_ppas
fi

# Update package lists
print_success "Updating package lists..."
$UPDATE_CMD

# Install packages
print_success "Installing packages..."
for package in "${PACKAGES[@]}"; do
    case "$DISTRO" in
        ubuntu)
            case "$package" in
                bat)
                    print_success "Installing bat..."
                    $PKG_MANAGER bat

                    # Create an alias for bat
                    if [ ! -f /usr/local/bin/bat ]; then
                        sudo ln -s /usr/bin/batcat /usr/local/bin/bat
                    fi

                    print_success "Alias 'bat' created for 'batcat'"
                    ;;
                *)
                    print_success "Installing $package..."
                    $PKG_MANAGER $package
                    ;;
            esac
            ;;
        *)
            print_success "Installing $package..."
            $PKG_MANAGER $package
            ;;
    esac
done

# Install Cascadia Code Nerd Font
if [ -n "$FONT_PACKAGE" ]; then
    print_success "Installing font package: $FONT_PACKAGE"
    $PKG_MANAGER $FONT_PACKAGE
else
    print_success "Installing Cascadia Code Nerd Font manually..."
    FONTS_DIR="$HOME/.fonts"
    mkdir -p "$FONTS_DIR"

    # Download the font files
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip"
    wget "$FONT_URL" -O CascadiaCode.zip

    # Verify the download
    if [ ! -f "CascadiaCode.zip" ]; then
        echo "Failed to download Cascadia Code font."
        exit 1
    fi

    # Unzip the font files
    unzip -o "CascadiaCode.zip" -d "$FONTS_DIR"

    # Remove the zip file
    rm "CascadiaCode.zip"

    # Refresh font cache
    sudo fc-cache -fv

    print_success "Fonts installed."
fi

# Change directory to ~/dotfiles and run 'stow'
DOTFILES_DIR="$HOME/dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    print_success "Changing directory to $DOTFILES_DIR"
    cd "$DOTFILES_DIR"

    print_success "Running 'stow' to create symbolic links..."
    stow zshrc kitty nvim tmux fastfetch tmuxifier

    print_success "Dotfiles have been stowed successfully."
else
    echo "Directory $DOTFILES_DIR does not exist"
    exit 1
fi

# Install Tmux Plugin Manager (tpm)
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    print_success "Cloning Tmux Plugin Manager to $TPM_DIR"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    print_success "Tmux Plugin Manager already installed at $TPM_DIR"
fi

# Change default shell to zsh
print_success "Changing default shell to zsh..."
chsh -s $(which zsh)

print_success "Setup complete."
