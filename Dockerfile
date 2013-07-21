FROM ubuntu
MAINTAINER Patrick O'Doherty <p@trickod.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y curl default-jre-headless

# Download the latest .deb and install
RUN curl http://aphyr.com/riemann/riemann_0.2.2_all.deb >> /tmp/riemann_0.2.2_all.deb
RUN dpkg -i /tmp/riemann_0.2.2_all.deb

# Hack to stop riemann crashing due to the unknown hostname

EXPOSE 5555
EXPOSE 5555/udp
EXPOSE 5556

CMD echo "127.0.0.1 $(hostname) > /etc/hosts"; /usr/bin/riemann /etc/riemann/riemann.config
