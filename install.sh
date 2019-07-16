#!/bin/bash
sudo sed -i 's/stretch/sid/g' /etc/apt/sources.list
sudo sed -i 's/stable/sid/g' /etc/apt/sources.list
sudo sed -i 's/testing/sid/g' /etc/apt/sources.list
sudo sed -i 's/ main\n/ main contrib non-free\n/g' /etc/apt/sources.list

echo "Updating..."
sudo apt update
sudo apt full-upgrade

echo 'Installing new programs...'
sudo apt install i3 xorg xinit libasound2 libasound2-doc alsa-utils alsa-oss alsamixergui pulseaudio snapd curl i3blocks fonts-font-awesome nvidia-detect compton ttf-mscorefonts-installer tilix firefox xclip
sudo apt remove xterm
sudo snap install --classic code

echo "[!!!] Edit the \$PATH variable (in /etc/profile):"
read -p "Press [ENTER] to continue..." -s && echo ""

echo 'Updating configs...'

mkdir -p ~/.config/i3blocks
curl https://gist.githubusercontent.com/trustedtomato/cf0fe3f454769787b06b407e3600c7e9/raw/i3blocks > ~/.config/i3blocks/config

mkdir -p ~/.config/i3
curl https://gist.githubusercontent.com/trustedtomato/cf0fe3f454769787b06b407e3600c7e9/raw/i3 > ~/.config/i3/config

curl https://gist.githubusercontent.com/trustedtomato/cf0fe3f454769787b06b407e3600c7e9/raw/compton.conf > ~/.config/compton.conf

mkdir ~/scripts
curl https://gist.githubusercontent.com/trustedtomato/cf0fe3f454769787b06b407e3600c7e9/raw/volume.py > ~/scripts/volume.py
chmod +x ~/scripts/volume.py

curl https://gist.githubusercontent.com/trustedtomato/cf0fe3f454769787b06b407e3600c7e9/raw/.bash_aliases > ~/.bash_aliases

echo 'exec i3' > ~/.xinitrc

echo '[!!!] Run nvidia-detector to install drivers!'

read -p "Press [ENTER] to reboot..." -s && echo ""
systemctl reboot