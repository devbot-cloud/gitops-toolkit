#!/bin/bash


WORKING_DIR="$(dirname "$(realpath "$0")")"

echo "Running envioment precheck..."

# Check if $HOME/.local/bin is a directory and create it if not
if [ -d "$HOME/.local/bin" ]; then
    echo -e "- Directory Exists ✅"
else
    mkdir -p "$HOME/.local/bin"
    echo -e "- Directory Created 🆗"
fi

# Check if $HOME/.local/bin is in the PATH and add it to ~/.bashrc if not
if echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo -e "- Directory in PATH ✅"
else
    if grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
        echo -e "- Directory already added to PATH ✅"
    else
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo -e "- Directory added to PATH 🆗"
    fi
    export PATH="$PATH:$HOME/.local/bin"
    echo "Please run (source ~/.bashrc) ❌❌"
fi


# Install kubectl
$WORKING_DIR/install_remote.sh "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" "kubectl"


