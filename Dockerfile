FROM ubuntu:latest

LABEL org.opencontainers.image.source="https://github.com/simeononsecurity/docker-ubuntu-hardened"
LABEL org.opencontainers.image.description="Hardened Docker Container with arm, arm64, and amd64 support"
LABEL org.opencontainers.image.authors="simeononsecurity"

ENV DEBIAN_FRONTEND noninteractive
ENV container docker
ENV TERM=xterm

# Update Packages
RUN apt-get update && \
  apt-get -y --no-install-recommends install apt-utils && \ 
  apt-get -fuy full-upgrade -y && \
  apt-get -fuy install git aide iptables ufw software-properties-common dnsutils apparmor kmod systemd automake net-tools procps cmake make python3 python3-pip python3-dev

# Install Ansible
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt-get install -y ansible

#Download and run konstruktoid.hardening Playbook
RUN git clone https://github.com/simeononsecurity/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

# Clean APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/bin/bash" ]
