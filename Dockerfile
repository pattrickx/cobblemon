# Use Alpine because it's more secure, more performant and more size friendly
FROM alpine:3

# Install everything we need (including git before cloning)
RUN apk add --no-cache \
    openjdk21-jre \
    jq \
    rcon \
    git \
    nano

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -g 10001 cobblemon && \
    adduser -D -u 10000 -G cobblemon cobblemon

# Set working directory
WORKDIR /home/cobblemon

# Clone the private repository (use build args or SSH in CI for private repos)
RUN git clone https://github.com/pattrickx/cobblemon.git .

# Copy the entrypoint script
COPY cobblemon.sh ./

# Fix entrypoint script permissions
RUN chown cobblemon:cobblemon cobblemon.sh && \
    chmod +x cobblemon.sh

# Note: USER is not set here because of possible volume permission issues.
# The entrypoint script should drop privileges if needed.

# Launch entrypoint script to run the server
ENTRYPOINT ["/home/cobblemon/cobblemon.sh"]
