# Use Debian because glibcl is a dependency of SteamCMD
FROM debian:12-slim

# Install everything we need
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
    lib32gcc-s1 \
    libcurl4-gnutls-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -gid 10001 dst && \
    adduser -disabled-password -u 10000 -ingroup dst dst

# Set working directory
WORKDIR /home/dst

# Copy the entrypoint script
COPY dst.sh ./

# Fix the entrypoint script permissions
RUN chown dst:dst dst.sh && \
    chmod +x dst.sh

# USER is not being used, but we are actually running the server as the dst user inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT ["/home/dst/dst.sh"]