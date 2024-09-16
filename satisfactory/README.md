# Custom configuration

If you want to change the default configuration, you can do so by adding a set of optional environment variables to the docker compose

# Example

```yaml
services:
  satisfactory:
    image: delath/satisfactory
    container_name: satisfactory
    ports:
      - '7777:7777/tcp'
      - '7777:7777/udp'
    volumes:
      - './Server:/config'
    restart: 'unless-stopped'
    environment:
      - MAXPLAYERS=4
```
