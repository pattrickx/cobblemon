#!/bin/bash

# Get the terraria server version from official API
version=$(echo "$(curl -s https://terraria.org/api/get/dedicated-servers-names)" | grep -o '[0-9]\+' | uniq)

# Get the terraria server zip from official API
wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-$version.zip -P /home/terraria/

# Unzip the terraria server zip
unzip /home/terraria/terraria-server-$version.zip -d /home/terraria/

# Give executable permissions to the binary used to launch the server
chmod +x /home/terraria/$version/Linux/TerrariaServer.bin.x86*

# Start the server with the config file and allowing steam friends to join you easily
/home/terraria/$version/Linux/TerrariaServer.bin.x86_64 -config /home/terraria/config -steam -lobby friends