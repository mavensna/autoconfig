#!/bin/sh

## Installing all the packages
sudo chmod +x package_installation.sh
./package_installation.sh

## Enable and start network manager
sudo systemctl enable NetworkManager.service
sudo systemctl start NetworkManager.service

## Enable and start bluetooth manager
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

## Installing oh-my-zsh (Will automatically ask for changing the shell)
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

## Initialize git
# Prompt user for email
read -p "Enter your email address for Git: " email

# Prompt user for name
read -p "Enter your name for Git: " name

# Set global Git configurations
git config --global user.email "$email"
git config --global user.name "$name"

echo "Global Git credentials initialized:"
echo "Email: $email"
echo "Name: $name"

## Setting up github ssh tokens 
# Prompt user for GitHub username
read -p "Enter your GitHub username: " username

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "$username"

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add the SSH private key to the SSH agent
ssh-add ~/.ssh/id_rsa

# Print the SSH public key
echo "Your SSH public key:"
cat ~/.ssh/id_rsa.pub

# Prompt user to copy and add the SSH key to their GitHub account
read -p "Add the SSH key to your GitHub account. Press enter when done..."

# Test SSH connection to GitHub
yes | ssh -T git@github.com

echo "SSH keys synced with your GitHub account."

## Cloning the vim plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Copy the background image to pictures folder
mkdir ~/pictures
mkdir ~/pictures/backgrounds
cp background.jpg ~/pictures/backgrounds/

## Setting up cloudflare warp
sudo systemctl enable warp-svc.service
sudo systemctl start warp-svc.service

## Managing dotfiles
cd ~
git clone https://github.com/mavensna/.dotfiles.git
cd .dotfiles
stow .
