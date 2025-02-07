#!/bin/ash

# Check if EULA has been accepted
if [ -z "$EULA" ]; then
    echo "Variable EULA not defined, see docs to know how to accept EULA."
    exit 1
fi

# Fetch latest Server jar url
VERSIONS_JSON=$(curl --ipv4 -s "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json")
RELEASE="1.20.4"
VERSION_URL=$(echo $VERSIONS_JSON | jq -r --arg VERSION "$RELEASE" '.versions[] | select(.id == $VERSION and .type == "release") | .url')
JAR_URL=$(curl --ipv4 -s $VERSION_URL | jq -r '.downloads.server.url')

# Default the allocated ram to 4G if not set
if [ -z "$ALLOCATED_RAM" ]; then
    echo "Variable ALLOCATED_RAM not defined."
    ALLOCATED_RAM="4G"
fi

# If this is the first time running the container
if [ ! -d "/home/skyblock/server/world" ]; then
    # Fetch all the skyblock datapacks
    mkdir -p /home/skyblock/server/world/datapacks
    cd /home/skyblock/server/world/datapacks
    ISLAND_DATAPACK_URL=$(curl --ipv4 -sL https://api.github.com/repos/BluePsychoRanger/SkyBlock_Collection/releases/latest | jq -r '.assets[] | select(.name? | match("skyvoid_island_standard.*.zip$")) | .browser_download_url')
    WORLDGEN_DATAPACK_URL=$(curl --ipv4 -sL https://api.github.com/repos/BluePsychoRanger/SkyBlock_Collection/releases/latest | jq -r '.assets[] | select(.name? | match("skyvoid_worldgen_empty.*.zip$")) | .browser_download_url')
    curl --ipv4 -L -o skyvoid_island_standard.zip $ISLAND_DATAPACK_URL
    curl --ipv4 -L -o skyvoid_worldgen_empty.zip $WORLDGEN_DATAPACK_URL

    # Download and setup the latest Server jar 
    cd /home/skyblock/server
    curl --ipv4 -o server.jar $JAR_URL
    echo "eula=${EULA}" > eula.txt
    chmod +x server.jar
else
    # Remove the island generation datapack, as it will try to constantly create a new island on container restart 
    cd /home/skyblock/server/world/datapacks
    rm skyvoid_island_standard.zip
fi
chown -R skyblock:skyblock /home/skyblock

# Launch the Server jar
cd /home/skyblock/server
su -c "java -Xmx${ALLOCATED_RAM} -Xms${ALLOCATED_RAM} -jar server.jar nogui" skyblock
