#!/bin/sh

if [ -z "$MAXPLAYERS" ]; then
    MAXPLAYERS="12"
fi

mkdir /home/satisfactory/server

mkdir ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +@sSteamCmdForcePlatformType linux +force_install_dir /home/satisfactory/server +login anonymous +app_update 1690800 validate +quit

cd /home/satisfactory/server

chown -R satisfactory:satisfactory /home/satisfactory

su -c "./FactoryServer.sh" satisfactory