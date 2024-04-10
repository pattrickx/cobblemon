# Does it make sense to use a builder? is it not going to be compatible often? i'd prefer steamCMD on alpine, but we need to define if it is actually doable



######## BUILDER ########

# Set the base image
FROM steamcmd/steamcmd:ubuntu-22 as builder

# Set environment variables
ENV USER root
ENV HOME /root/installer

# Set working directory
WORKDIR $HOME

# Install prerequisites
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl tar

######## INSTALL ########

# Set the base image
FROM alpine:3

# Set environment variables
ENV USER root
ENV HOME /root

# Set working directory
WORKDIR $HOME

# Install prerequisites
RUN apk update \
 && apk add --no-cache bash \
 && rm -rf /var/cache/apk/*

# Copy required files from builder
COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /lib/i386-linux-gnu /lib/
COPY --from=builder /root/installer/linux32/libstdc++.so.6 /lib/

# Install everything we need
RUN apk add --no-cache \
    unzip \
    curl \
    tmux

# Create a user and usergroup with high UID and GID to not overlap with an existing host user or usergroup
RUN addgroup -g 10001 terraria && \
    adduser -D -u 10000 -G terraria terraria

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






