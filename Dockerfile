FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
ENV container docker
ENV TERM=xterm

# Update Packages
RUN apt-get update && apt-get -fuy full-upgrade -y && apt-get -fuy install git aide iptables ufw software-properties-common dnsutils apparmor kmod systemd automake net-tools procps cmake make python3 python3-pip python3-dev

# Install Ansible
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt-get install -y ansible

RUN git clone https://github.com/simeononsecurity/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

ENTRYPOINT [ "/bin/bash" ]
