FROM ubuntu
MAINTAINER Patrick O'Doherty <p@trickod.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl default-jre-headless

# Download the latest .deb and install
RUN curl http://aphyr.com/riemann/riemann_0.2.4_all.deb > /tmp/riemann_0.2.4_all.deb
RUN dpkg -i /tmp/riemann_0.2.4_all.deb

# Expose the ports for inbound events and websockets
EXPOSE 5555
EXPOSE 5555/udp
EXPOSE 5556

# Share the config directory as a volume
VOLUME /etc/riemann
ADD riemann.config /etc/riemann/riemann.config

# Set the hostname in /etc/hosts so that Riemann doesn't die due to unknownHostException
CMD echo 127.0.0.1 $(hostname) > /etc/hosts; /usr/bin/riemann /etc/riemann/riemann.config
