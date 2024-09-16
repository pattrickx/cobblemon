#!/bin/sh

if [ -z "$MAXPLAYERS" ]; then
    MAXPLAYERS="Name"
fi

mkdir /home/satisfactory/server

mkdir ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +@sSteamCmdForcePlatformType linux +force_install_dir /home/satisfactory/server +login anonymous +app_update 1690800 validate +quit

cd /home/satisfactory/server

#export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH  
#export SteamAppID=1690800
#
#chown -R satisfactory:satisfactory /home/satisfactory
#
#echo "Starting server PRESS CTRL-C to exit"  
#
#su -c "/home/satisfactory/server/satisfactory_server" satisfactory