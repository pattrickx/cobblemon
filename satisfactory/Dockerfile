# Use Debian because glibcl is a dependency of SteamCMD
FROM debian:stable-slim

# Install everything we need
RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -gid 10001 satisfactory && \
    adduser -disabled-password -u 10000 -ingroup satisfactory satisfactory

# Set working directory
WORKDIR /home/satisfactory

# Copy the entrypoint script
COPY satisfactory.sh ./

# Fix the entrypoint script permissions
RUN chown satisfactory:satisfactory satisfactory.sh && \
    chmod +x satisfactory.sh

# USER is not being used, but we are actually running the server as the satisfactory user inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/satisfactory/satisfactory.sh