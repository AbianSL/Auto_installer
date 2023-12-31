#!/bin/bash

install_programming_lang_packages() {
    case $1 in
        opensuse)
            echo "Detected OpenSUSE distribution."
            install_programming_lang_packages_opensuse
            ;;
        arch)
            echo "Detected Arch Linux distribution."
            install_programming_lang_packages_arch
            ;;
        debian)
            echo "Detected Debian distribution."
            install_programming_lang_packages_debian
            ;;
        *)
            echo "Unsupported distribution detected"
            exit 1
            ;;
    esac
}

install_programming_lang_packages_opensuse() {
    sudo zypper install gcc-c++ make cmake ruby3 openjdk-17-jdk python swi-prolog gdb
    echo "Installing kotlin..."
    echo "If you want to install kotlin you need to install sdkman."
    echo "Do you want to install sdkman? (y/n)"
    read confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
    sudo zypper install curl
    curl -s https://get.sdkman.io | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install kotlin
}

install_programming_lang_packages_arch() {
    sudo pacman -S gcc make cmake ruby jdk-openjdk jre-openjdk python python3 swi-prolog kotlin gdb
}

install_programming_lang_packages_debian() {
    sudo apt-get update
    sudo apt-get install g++ make cmake ruby-full default-jre default-jdk python3 swi-prolog gdb
    echo "Installing kotlin..."
    echo "If you want to install kotlin you need to install sdkman."
    echo "Do you want to install sdkman? (y/n)"
    read confirmation
    confirmation="$(echo "$confirmation" | tr '[:upper:]' '[:lower:]')"
    if [ "$confirmation" != "yes" ] && [ "$confirmation" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
    sudo apt-get install curl
    curl -s https://get.sdkman.io | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
}
