#!/bin/sh

mkdir ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +@sSteamCmdForcePlatformType linux +force_install_dir /home/dst/server +login anonymous +app_update 343050 +quit

cd /home/dst/server

export SteamAppId=322330
export SteamGameId=322330#

chown -R dst:dst /home/dst

su -c "cd /home/dst/server/bin64/ && exec ./dontstarve_dedicated_server_nullrenderer_x64" dst
