# Use Alpine because it's more secure, more performant and more size friendly
FROM alpine:3

# Install everything we need
RUN apk add --no-cache \
    openjdk21-jre \
    jq \
    rcon

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -g 10001 cobblemon && \
    adduser -D -u 10000 -G cobblemon cobblemon

# Set working directory
WORKDIR /home/cobblemon

# Copy the entrypoint script
COPY cobblemon.sh ./

# Fix entrypoint script permissions
RUN chown cobblemon:cobblemon cobblemon.sh && \
    chmod +x cobblemon.sh

# USER is not being used, but we are actually running the server as the cobblemon user inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT ["/home/cobblemon/cobblemon.sh"]