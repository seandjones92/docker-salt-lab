FROM ubuntu:20.04

RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://bootstrap.saltproject.io -o install_salt.sh
RUN sh install_salt.sh -P -M -x python3
RUN rm install_salt.sh
RUN echo "localhost" > /etc/salt/minion_id
RUN echo "master: localhost" > /etc/salt/minion.d/master.conf
RUN echo "auto_accept: True" > /etc/salt/master.d/accept.conf
RUN echo "salt-master -d && salt-minion -d" > /usr/local/bin/start_lab.sh

WORKDIR /root

ENTRYPOINT ["/bin/sh", "/usr/local/bin/start_lab.sh", "&&", "/bin/bash"]
