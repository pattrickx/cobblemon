#!/bin/sh

term_handler() {
    echo "Termination signal received, shutting down gracefully..."

    kill -TERM "$child" 2>/dev/null

    wait "$child"
    exit 0
}

trap term_handler SIGINT SIGTERM

if [ -z "$NAME" ]; then
    NAME="Name"
fi
if [ -z "$WORLD" ]; then
    WORLD="World"
fi
if [ -z "$PASSWORD" ]; then
    PASSWORD="Password"
fi

mkdir /home/valheim/server

mkdir -p ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +@sSteamCmdForcePlatformType linux +force_install_dir /home/valheim/server +login anonymous +app_update 896660 validate +quit

cd /home/valheim/server

export templdpath=$LD_LIBRARY_PATH  
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH  
export SteamAppID=892970

chown -R valheim:valheim /home/valheim

echo "Starting server PRESS CTRL-C to exit"  

su -c "/home/valheim/server/valheim_server.x86_64 -name \"$NAME\" -port 2456 -world \"$WORLD\" -password \"$PASSWORD\" -public 0 -crossplay" valheim &

child=$!
echo "Server started with PID $child"

wait "$child"

export LD_LIBRARY_PATH=$templdpath
