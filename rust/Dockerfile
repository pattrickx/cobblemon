# Use Debian because glibcl is a dependency of SteamCMD
FROM debian:12-slim

# Install everything we need
RUN apt-get update && apt-get install -y \
    lib32gcc-s1 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -gid 10001 rust && \
    adduser -disabled-password -u 10000 -ingroup rust rust

# Set working directory
WORKDIR /home/rust

# Copy the entrypoint script
COPY rust.sh ./

# Fix the entrypoint script permissions
RUN chown rust:rust rust.sh && \
    chmod +x rust.sh

# USER is not being used, but we are actually running the server as the rust user inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/rust/rust.sh