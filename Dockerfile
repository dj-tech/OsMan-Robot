# Use the offical Debian Docker image with a specified version tag, Wheezy, so not all
# versions of Debian images are downloaded.
FROM debian:wheezy
# Expose the container's network port: 25565 during runtime.
EXPOSE 25565
FROM phusion/passenger-ruby22:0.9.18

# Set correct environment variables.
ENV HOME /root
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Enable nginx + passenger
RUN rm -f /etc/service/nginx/down

# Get PInW
USER app
WORKDIR /home/app
RUN git clone https://github.com/AlgoLab/pinw
RUN mkdir data
WORKDIR /home/app/pinw
ENV RACK_ENV production

USER root
RUN bundle install

# New crontab:
USER root
COPY crontab /etc/crontab
COPY update-pinw.sh /usr/local/bin/update_pinw.sh
# Pinw cron jobs:
USER app
RUN whenever -w

# Add configuration to nginx:
USER root
RUN rm /etc/nginx/sites-enabled/default
COPY nginx-pinw.conf /etc/nginx/sites-enabled/pinw.conf

COPY init-ssh.sh /etc/my_init.d/init-ssh.sh

EXPOSE 80

COPY inituidgid.sh /usr/local/sbin
RUN  chmod u+x /usr/local/sbin/inituidgid.sh
