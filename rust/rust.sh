#!/bin/sh

#if [ -z "$NAME" ]; then
#    NAME="Name"
#fi
#if [ -z "$WORLD" ]; then
#    WORLD="World"
#fi
#if [ -z "$PASSWORD" ]; then
#    PASSWORD="Password"
#fi

mkdir /home/rust/server

mkdir ~/Steam && cd ~/Steam

curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

./steamcmd.sh +force_install_dir /home/rust/server +login anonymous +app_update 258550 validate +quit

cd /home/rust/server

chown -R rust:rust /home/rust

su -c "./runds.sh" rust
