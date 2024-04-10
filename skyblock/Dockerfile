# Use Alpine because it's more secure, more performant and more size friendly
FROM alpine:latest

# Install everything we need
RUN apk add --no-cache \
    rcon

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -g 10001 skyblock && \
    adduser -D -u 10000 -G skyblock skyblock

# Set working directory
WORKDIR /home/skyblock

# Copy the entrypoint script
COPY skyblock.sh ./

# Fix entrypoint script permissions
RUN chown skyblock:skyblock skyblock.sh && \
    chmod +x skyblock.sh

# USER is not being used, but we are actually running the server as the user previously created inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/skyblock/skyblock.sh