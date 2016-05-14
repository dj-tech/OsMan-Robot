# Use the offical Debian Docker image with a specified version tag, Wheezy, so not all
# versions of Debian images are downloaded.
FROM debian:wheezy
# Expose the container's network port: 25565 during runtime.
EXPOSE 25565
