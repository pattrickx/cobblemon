#!/bin/bash

jar_file = "/home/papermc/papermc.jar"
ALLOCATED_RAM = "4G"

if [[ -f "$jar_file" ]]; then # If a papermc.jar is already present
    mv $jar_file $jar_file.bak
fi



if [[ -z "$ALLOCATED_RAM" ]]; then # We might want to default this
    echo "Variable ALLOCATED_RAM not defined."

    exit 1
fi

java -Xmx${ALLOCATED_RAM} -Xms${ALLOCATED_RAM} -jar paper.jar --nogui

exit 0