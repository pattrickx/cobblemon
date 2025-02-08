# Custom configuration

If you want to change the default configuration, you can do so by adding a set of optional environment variables to the docker compose

WORLD_SIZE Is the size of your server, the larger the map, the more disk space and memory you need. Use 1000 to 6000
  ```yaml
  environment:
    - WORLD_SIZE=6000
  ```

MAX_PLAYERS Is the maximum number of players connected at the same time
  ```yaml
  environment:
    - MAX_PLAYERS=6000
  ```

SERVER_NAME Is the name of your server
  ```yaml
  environment:
    - SERVER_NAME=Name
  ```

SERVER_DESCRIPTION Is the server description
  ```yaml
  environment:
    - SERVER_DESCRIPTION=Welcome
  ```

SERVER_WEBSITE Is the website of your server
  ```yaml
  environment:
    - SERVER_WEBSITE=https://github.com/delath/containers-hub
  ```

SERVER_IMAGE Is the image of your server
  ```yaml
  environment:
    - SERVER_IMAGE=https://shared.cloudflare.steamstatic.com/store_item_assets/steam/apps/252490/header.jpg
  ```

# Example

```yaml
services:
  rust:
    image: delath/rust
    container_name: rust
    ports:
      - "28015:28015/tcp"
      - "28015:28015/udp"
      - "28016:28016/udp"
      - "28082:28082/tcp"
    volumes:
      - ./Server:/home/rust/server
    restart: 'unless-stopped'
    environment:
      - WORLD_SIZE=6000
      - SERVER_NAME=Name
```