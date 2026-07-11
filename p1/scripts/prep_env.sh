#!/bin/bash

# Ensure script stops instantly if any command fails
set -e

echo "=== Starting 42 Environment Preparation for Inception ==="

# 1. Define paths dynamically using the active student login session
GOINFRE_DIR="/home/$USER/goinfre/vagrant_storage"
VB_DIR="$GOINFRE_DIR/VirtualBoxVMs"

echo "Checking storage space configurations..."

# 2. Create target storage directories if they do not exist
if [ ! -d "$GOINFRE_DIR" ]; then
    echo "Creating directory: $GOINFRE_DIR"
    mkdir -p "$GOINFRE_DIR"
fi

if [ ! -d "$VB_DIR" ]; then
    echo "Creating directory: $VB_DIR"
    mkdir -p "$VB_DIR"
fi

# # 3. Secure the folder permissions so your work stays protected from other cluster users
# chmod 700 "/home/$USER/goinfre"
# chmod -R 700 "$GOINFRE_DIR"

# 4. Set the global VirtualBox Virtual Machine storage folder properties
echo "Redirecting VirtualBox machine storage folder..."
VBoxManage setproperty machinefolder "$VB_DIR"

# # 5. Authorize custom static IP subnets (192.168.x.x) on VirtualBox engine
# echo "Configuring network policies for VirtualBox..."
# sudo mkdir -p /etc/vbox
# echo "* 10.0.0.0/8 192.168.0.0/16" | sudo tee /etc/vbox/networks.conf > /dev/null

# 6. Safely bind VAGRANT_HOME to your shell configuration if it's missing
ZSH_CONFIG="$HOME/.zshrc"
VAGRANT_EXPORT="export VAGRANT_HOME=\"$GOINFRE_DIR\""

if ! grep -q "VAGRANT_HOME" "$ZSH_CONFIG"; then
    echo "Adding VAGRANT_HOME to $ZSH_CONFIG..."
    echo "" >> "$ZSH_CONFIG"
    echo "# 42 Inception of Things Vagrant Storage Redirect" >> "$ZSH_CONFIG"
    echo "$VAGRANT_EXPORT" >> "$ZSH_CONFIG"
else
    echo "VAGRANT_HOME parameter is already tracked inside $ZSH_CONFIG"
fi

echo "========================================================="
echo " Preparation Finished Successfully!"
echo " IMPORTANT: Run the command below to update your terminal:"
echo "     source ~/.zshrc"
echo "========================================================="