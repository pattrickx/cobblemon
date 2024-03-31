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
version: '3.8'

services:
  papermc:
    image: delath/papermc
    container_name: papermc
    ports:
      - "25565:25565"
    volumes:
      - ./world:/home/papermc/world
    restart: 'unless-stopped'
    environment:
      - ALLOCATED_RAM=8G
      - EULA=true
    tty: true
```
