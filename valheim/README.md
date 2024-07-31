# Custom configuration

If you want to change the default configuration, you can do so by adding a set of optional environment variables to the docker compose

NAME Is the name of the your server
  ```yaml
  environment:
    - NAME=Name
  ```

WORLD Is the name of the your world and of the save file
  ```yaml
  environment:
    - WORLD=World
  ```

PASSWORD Is the password of your server, the users will need to enter it when logging in
  ```yaml
  environment:
    - PASSWORD=Password
  ```

# Example

```yaml
services:
  valheim:
    image: delath/valheim
    container_name: valheim
    ports:
      - "2456:2456"
      - "2457:2457"
    volumes:
      - ./World:/home/valheim/.config/unity3d/IronGate/Valheim
      - ./Server:/home/valheim/server/.config/unity3d/IronGate/Valheim
    restart: 'unless-stopped'
    environment:
      - NAME=Name
      - WORLD=World
      - PASSWORD=Password
```
