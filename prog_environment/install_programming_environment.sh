#!/bin/bash

install_programming_environment() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_programming_environment_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_programming_environment_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_programming_environment_debian
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_lunar_vim() {
    echo "Installing LunarVim..."
    LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
}

install_programming_environment_opensuse() {
    sudo zypp
}

install_programming_environment_arch() {
    AUR_MANAGER="$(search_aur_manager)"
    $AUR_MANAGER -S visual-studio-code-bin android-studio
    echo "Installing dependencies for LunarVim..."
    sudo pacman -S git make python npm node cargo rust python-pip
    sleep 1
    install_lunar_vim
}

install_programming_environment_debian() {
    echo "To install Visual Studio Code, you'll need to install snapd."
    read -p "Do you want to install snapd? [y/N] " answer
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
    if [[ $answer == "y" || $answer == "yes" ]]; then
        sudo apt install snapd
    fi
    sudo snap install --classic code

    echo "Installing dependencies for LunarVim..."
    sudo apt install git make python3 npm nodejs cargo rust python3-pip
    install_lunar_vim
}
