FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
ENV container docker
ENV TERM=xterm


# Update Packages
RUN apt-get update && apt-get -fuy full-upgrade -y && apt-get -fuy install git dnsutils apparmor kmod systemd automake net-tools procps cmake make python3 python3-pip python3-dev

# Install Ansible
RUN apt-get install software-properties-common
RUN sudo add-apt-repository --yes --update ppa:ansible/ansible
RUN sudo apt-get install ansible

ENTRYPOINT [ "/bin/bash" ]
