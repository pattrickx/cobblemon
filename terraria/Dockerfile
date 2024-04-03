# Use Debian because it's the most stable between the officially supported operating systems
FROM debian:latest

# Install everything we need
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    tmux

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -g 10001 terraria && \
    adduser -D -u 10000 -G terraria terraria

# Set working directory
WORKDIR /home/terraria

# Copy the entrypoint script and the config file
COPY terraria.sh config ./

# Fix entrypoint script and config file permissions
RUN chown terraria:terraria terraria.sh && \
    chown terraria:terraria config && \
    chmod +x terraria.sh && \

# USER is not being used, but we are actually running the server as the user previously created inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/terraria/terraria.sh