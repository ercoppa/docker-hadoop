FROM ubuntu:16.04
MAINTAINER Emilio Coppa <ercoppa@gmail.com>

RUN apt-get update && apt-get install -y sudo && apt clean

RUN useradd -m ubuntu && \
 echo ubuntu:ubuntu | chpasswd && \
 cp /etc/sudoers /etc/sudoers.bak && \ 
 echo 'ubuntu  ALL=(root) NOPASSWD: ALL' >> /etc/sudoers
   
USER ubuntu
WORKDIR /home/ubuntu

COPY pig-0.15.0.tar.gz .   
COPY hadoop-2.7.6.tar.gz .
COPY *.xml *.sh *.conf hadoop_env.header install.sh /home/ubuntu/

RUN ./install.sh ; rm install.sh
