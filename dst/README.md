# Usage

You have to generate the server configuration [from the official klei website](https://accounts.klei.com/account/game/servers?game=DontStarveTogether), then unzip the contents in a folder named "MyDediServer" in the same directory as the docker compose.

# Example

```yaml
services:
  dst:
    image: delath/dst
    container_name: dst
    ports:
      - "10999:10999/udp"
      - "11000:11000/udp"
      - "12346:12346/udp"
      - "12347:12347/udp"
    volumes:
      - ./Server:/home/dst/server
      - ./MyDediServer:/home/dst/.klei/DoNotStarveTogether/Cluster_1
    restart: 'unless-stopped'
```
