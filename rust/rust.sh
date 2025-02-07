#!/bin/sh

if [ -z "$WORLD_SIZE" ]; then
    WORLD_SIZE="4000"
fi
if [ -z "$MAX_PLAYERS" ]; then
    MAX_PLAYERS="40"
fi
if [ -z "$SERVER_NAME" ]; then
    SERVER_NAME="ServerName"
fi
if [ -z "$SERVER_DESCRIPTION" ]; then
    SERVER_DESCRIPTION="Hosted from github.com/delath/containers-hub/tree/main/rust"
fi
if [ -z "$SERVER_WEBSITE" ]; then
    SERVER_WEBSITE="https://github.com/delath/containers-hub"
fi
if [ -z "$SERVER_IMAGE" ]; then
    SERVER_IMAGE="https://shared.cloudflare.steamstatic.com/store_item_assets/steam/apps/252490/header.jpg"
fi
if [ -z "$RCON_PASSWORD" ]; then
    RCON_PASSWORD="password"
fi

mkdir ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +force_install_dir /home/rust/server +login anonymous +app_update 258550 validate +quit

cd /home/rust/server

chown -R rust:rust /home/rust

su -c '
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`dirname $0`/RustDedicated_Data/Plugins:`dirname $0`/RustDedicated_Data/Plugins/x86_64;
  ./RustDedicated -batchmode +server.worldsize $WORLD_SIZE +server.maxplayers $MAX_PLAYERS +server.hostname $SERVER_NAME +server.description $SERVER_DESCRIPTION +server.url $SERVER_WEBSITE +server.headerimage $SERVER_WEBSITE +rcon.password $RCON_PASSWORD -logfile 2>&1
' rust
