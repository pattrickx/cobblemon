# Use Alpine because it's more secure, more performant and more size friendly
FROM alpine:latest

# Install everything we need
RUN apk add --no-cache \
    openjdk21-jre \
    curl \
    jq \
    rcon

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -g 10001 papermc && \
    adduser -D -u 10000 -G papermc papermc

# Set working directory
WORKDIR /home/papermc

# Copy the entrypoint script
COPY papermc.sh papermc.sh

# Fix entrypoint script permissions
RUN chown papermc:papermc papermc.sh && \
    chmod +x papermc.sh

# USER is not being used, but we are actually running the server as the user previously created inside the entrypoint
# The reason is conflicts with volumes permissions while wanting to have this streamlined as much as possible 

# Launch entrypoint script to run the server
ENTRYPOINT /home/papermc/papermc.sh