#!/bin/bash

# Download and unzip the latest terraria server from the official APIs
version=$(echo "$(curl -s https://terraria.org/api/get/dedicated-servers-names)" | grep -o '[0-9]\+' | uniq)
curl -o /home/terraria/terraria-server.zip https://terraria.org/api/download/pc-dedicated-server/terraria-server-$version.zip
unzip /home/terraria/terraria-server.zip -d /home/terraria/
rm /home/terraria/terraria-server.zip

# Configure the server by building a config file with the environment variables
CONFIG_FILE_PATH="/home/terraria/config"
echo "worldname=world" >> "$CONFIG_FILE_PATH"
echo "world=/home/terraria/world/world.wld" >> "$CONFIG_FILE_PATH"
echo "worldpath=/home/terraria/world/" >> "$CONFIG_FILE_PATH"
echo "port=7777" >> "$CONFIG_FILE_PATH"
if [ -z "$AUTOCREATE" ]; then
    AUTOCREATE=3
fi
echo "autocreate=$AUTOCREATE" >> "$CONFIG_FILE_PATH"
if [ -n "$SEED" ]; then
    echo "seed=$SEED" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$DIFFICULTY" ]; then
    echo "difficulty=$DIFFICULTY" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$MAXPLAYERS" ]; then
    echo "maxplayers=$MAXPLAYERS" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$PASSWORD" ]; then
    echo "password=$PASSWORD" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$MOTD" ]; then
    echo "motd=$MOTD" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$SECURE" ]; then
    echo "secure=$SECURE" >> "$CONFIG_FILE_PATH"
fi
if [ -z "$LANGUAGE" ]; then
    LANGUAGE=en-US
fi
echo "language=$LANGUAGE" >> "$CONFIG_FILE_PATH"
if [ -n "$UPNP" ]; then
    echo "upnp=$UPNP" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$NPCSTREAM" ]; then
    echo "npcstream=$NPCSTREAM" >> "$CONFIG_FILE_PATH"
fi
if [ -n "$PRIORITY" ]; then
    echo "priority=$PRIORITY" >> "$CONFIG_FILE_PATH"
fi

# Fix permissions to launch the terraria server
chown -R terraria:terraria /home/terraria
chmod +x /home/terraria/$version/Linux/TerrariaServer.bin.x86*

# Create a new tmux session
tmux new-session -d -s "terraria"

# Start the server with the config file and allowing steam friends to join you easily
tmux send-keys -t "terraria" "su -c '/home/terraria/$version/Linux/TerrariaServer.bin.x86_64 -config /home/terraria/config -steam -lobby friends' terraria" Enter

# Attach to the tmux session
tmux attach -t "terraria"