# Warning!

The MAXPLAYERS env is not yet supported, it is useless as of now.

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
