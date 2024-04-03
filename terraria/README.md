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
