#!/bin/sh

export WORLD_SIZE="${WORLD_SIZE:-4000}"
export MAX_PLAYERS="${MAX_PLAYERS:-40}"
export SERVER_NAME="${SERVER_NAME:-ServerName}"
export SERVER_DESCRIPTION="${SERVER_DESCRIPTION:-Hosted from github.com/delath/containers-hub/tree/main/rust}"
export SERVER_WEBSITE="${SERVER_WEBSITE:-https://github.com/delath/containers-hub}"
export SERVER_IMAGE="${SERVER_IMAGE:-https://shared.cloudflare.steamstatic.com/store_item_assets/steam/apps/252490/header.jpg}"
export RCON_PASSWORD="${RCON_PASSWORD:-password}"

mkdir ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +force_install_dir /home/rust/server +login anonymous +app_update 258550 validate +quit

cd /home/rust/server

chown -R rust:rust /home/rust

su -c "
  export LD_LIBRARY_PATH=\"\$LD_LIBRARY_PATH:/home/rust/server/RustDedicated_Data/Plugins:/home/rust/server/RustDedicated_Data/Plugins/x86_64\";
  ./RustDedicated -batchmode \
    +server.worldsize \"$WORLD_SIZE\" \
    +server.maxplayers \"$MAX_PLAYERS\" \
    +server.hostname \"$SERVER_NAME\" \
    +server.description \"$SERVER_DESCRIPTION\" \
    +server.url \"$SERVER_WEBSITE\" \
    +server.headerimage \"$SERVER_IMAGE\" \
    +rcon.password \"$RCON_PASSWORD\" \
    -logfile 2>&1
" rust
