# Warning!

As of now an issue has been dodged with the skyblock mod by [flagging the status of the container in the entrypoint](https://github.com/delath/containers-hub/blob/2a44cb2d3e1a5b32a7cb196b28dd0e4b1a11ae46/skyblock/skyblock.sh#L21), this means that you should spin up the container for the first time, only when you will actually want to log in and play, so the island will generate and the flag responsible for the island creation will switch, sadly the skyblock mod is responsible for this, so not much can be done from this image.
I still plan to streamline this, maybe by logging a fake player to generate the island, or by manually switching the mod flag.


# Prerequisite

You need to accept EULA to run this server, you can do so by adding the following environment variable to the service configuration:

```yaml
environment:
  - EULA=true
```

# Increasing RAM Allocation

If you need to increase the RAM (by default it's 4GB), you can do so by adding the following environment variable to the service configuration:

```yaml
environment:
  - ALLOCATED_RAM=8G
```

# Example

```yaml
services:
  skyblock:
    image: delath/skyblock
    container_name: skyblock
    ports:
      - "25565:25565"
    volumes:
      - ./world:/home/skyblock/server
    restart: 'unless-stopped'
    environment:
      - ALLOCATED_RAM=8G
      - EULA=true
```

# Sending commands to the server console

If you want to send commands to the console you can leverage minecraft official rcon support, you would need to generate all server files by starting the server at least once and edit the `server.properties` rcon related fields 
```txt
enable-rcon=true
rcon.port=25575
rcon.password=<rcon_password>
```

Then you can send any command with the following syntax
```bash
docker exec -it skyblock sh -c "rcon -H localhost -p 25575 -P <rcon_password> <command>"
```
