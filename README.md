# Docker Salt Lab
Disposable saltstack lab in a container

## Dockerfile:
```
FROM ubuntu:20.04

RUN apt update && apt install -y curl
RUN curl -fsSL https://bootstrap.saltproject.io -o install_salt.sh
RUN sh install_salt.sh -P -M -x python3
RUN rm install_salt.sh
RUN echo "localhost" > /etc/salt/minion_id
RUN echo "master: localhost" > /etc/salt/minion.d/master.conf
RUN echo "auto_accept: True" > /etc/salt/master.d/accept.conf
RUN echo "salt-master -d && salt-minion -d" > /usr/local/bin/start_lab.sh

WORKDIR /root

ENTRYPOINT /bin/sh /usr/local/bin/start_lab.sh && /bin/bash
```

## Running
`docker run --rm -it sdj92/saltlab`

I use the following shell alias:
`alias saltlab="docker run --rm -it --hostname saltlab --name saltlab sdj92/saltlab"`

This gives me something like the following:
```
➜  ~ saltlab
root@saltlab:~# salt \* test.ping
saltlab:
    True
root@saltlab:~#
```