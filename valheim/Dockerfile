# Use Debian because glibcl is a dependency of SteamCMD
FROM debian:stable-slim

# Install everything we need
RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    libatomic1 \
    libpulse-dev \
    libpulse0 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -gid 10001 valheim && \
    adduser -disabled-password -u 10000 -ingroup valheim valheim

# Set working directory
WORKDIR /home/valheim

# Copy the entrypoint script
COPY valheim.sh ./

# Fix the entrypoint script permissions
RUN chown valheim:valheim valheim.sh && \
    chmod +x valheim.sh

# USER is not being used, but we are actually running the server as the valheim user inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/valheim/valheim.sh