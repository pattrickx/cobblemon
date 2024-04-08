# Use Debian because of glibcl and many other dependencies of the Terraria server
FROM debian:stable-slim

# Install everything we need
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -gid 10001 terraria && \
    adduser -disabled-password -u 10000 -ingroup terraria terraria

# Set working directory
WORKDIR /home/terraria

# Copy the entrypoint script
COPY terraria.sh ./

# Fix the entrypoint script permissions
RUN chown terraria:terraria terraria.sh && \
    chmod +x terraria.sh

# USER is not being used, but we are actually running the server as the user previously created inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/terraria/terraria.sh