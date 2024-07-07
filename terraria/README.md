# Warning!

Unfortunately by using tmux and having `tty` set to true in the docker compose, you **cannot** use the following command, as it will attach to the tmux session directly.
```bash
docker logs terraria
```

# Sending commands to the server console

If you want to send commands to the console you must use a combination of docker interactive mode and tmux
```bash
docker exec -it terraria sh -c "tmux send-keys -t 'terraria' '<command>' Enter"
```

# Custom configuration

If you want to change the default configuration, you can do so by adding a set of optional environment variables to the docker compose, to know more about them, refer to the [official terraria documentation](https://terraria.wiki.gg/wiki/Server)
  ```yaml
  environment:
    - AUTOCREATE=3
    - SEED=AwesomeSeed
    - DIFFICULTY=0
    - MAXPLAYERS=8
    - PASSWORD=p@55w0rd*
    - MOTD=Please don’t cut the purple trees!
    - SECURE=1
    - LANGUAGE=en-US
    - UPNP=1
    - NPCSTREAM=60
    - PRIORITY=1
  ```

# Example

```yaml
services:
  terraria:
    image: delath/terraria
    container_name: terraria
    ports:
      - "7777:7777"
    volumes:
      - ./world:/home/terraria/world
    restart: 'unless-stopped'
    environment:
      - DIFFICULTY=0
      - MAXPLAYERS=12
      - UPNP=0
    tty: true
```
