#!/bin/bash

# Download and unzip the latest terraria server from the official APIs
version=$(echo "$(curl -s https://terraria.org/api/get/dedicated-servers-names)" | grep -o '[0-9]\+' | uniq)
curl -o /home/terraria/terraria-server.zip https://terraria.org/api/download/pc-dedicated-server/terraria-server-$version.zip
unzip /home/terraria/terraria-server.zip -d /home/terraria/
rm /home/terraria/terraria-server.zip

# Fix permissions to launch the terraria server
chown -R terraria:terria /home/terraria
chmod +x /home/terraria/$version/Linux/TerrariaServer.bin.x86*

# Create a new tmux session
tmux new-session -d -s "terraria"

# Start the server with the config file and allowing steam friends to join you easily
tmux send-keys -t "papermc" "su -c '/home/terraria/$version/Linux/TerrariaServer.bin.x86_64 -config /home/terraria/config -steam -lobby friends' terraria" Enter

# Attach to the tmux session
tmux attach -t "terraria"