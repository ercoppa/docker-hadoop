FROM ubuntu:16.04
MAINTAINER Emilio Coppa <ercoppa@gmail.com>

RUN apt-get update && apt-get install -y sudo nano time git openjdk-8-jdk-headless openssh-server make python
# && rm -rf /var/lib/apt/lists/* && apt clean

RUN useradd -m ubuntu && \
 echo ubuntu:ubuntu | chpasswd && \
 cp /etc/sudoers /etc/sudoers.bak && \ 
 echo 'ubuntu  ALL=(root) NOPASSWD: ALL' >> /etc/sudoers
   
USER ubuntu
WORKDIR /home/ubuntu

COPY pig-0.15.0.tar.gz .   
COPY hadoop-2.7.6.tar.gz .
COPY *.xml *.sh *.conf hadoop_env.header /home/ubuntu/

RUN cat /dev/zero | ssh-keygen -t rsa -q -N ""
RUN ssh-keyscan -H localhost >> /home/ubuntu/.ssh/known_hosts
RUN ssh-keyscan -H 0.0.0.0 >> /home/ubuntu/.ssh/known_hosts
RUN ssh-keyscan -H 127.0.0.1 >> /home/ubuntu/.ssh/known_hosts
RUN cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
RUN tar xvf hadoop-*.tar.gz >/dev/null && rm hadoop-*.tar.gz && mv hadoop-* hadoop
RUN mkdir -p ~/hadoop/data/namenode
RUN mkdir -p ~/hadoop/data/datanode
RUN cat hadoop_env.header | cat - ~/hadoop/etc/hadoop/hadoop-env.sh > /tmp/out && mv /tmp/out ~/hadoop/etc/hadoop/hadoop-env.sh
RUN cp core-site.xml ~/hadoop/etc/hadoop/core-site.xml
RUN cp hdfs-site.xml ~/hadoop/etc/hadoop/hdfs-site.xml
RUN cp yarn-site.xml ~/hadoop/etc/hadoop/yarn-site.xml
RUN cp mapred-site.xml ~/hadoop/etc/hadoop/mapred-site.xml
RUN echo 'export PATH=$PATH:~/hadoop/bin:~/hadoop/sbin' >> ~/.bashrc
RUN ~/hadoop/bin/hdfs namenode -format 
RUN rm *.xml hadoop_env.header
RUN echo "sudo service ssh restart" >> /home/ubuntu/.bashrc
RUN echo 'export JAVA_HOME=`dirname $(readlink /etc/alternatives/java)`/../' >> /home/ubuntu/.bashrc
RUN echo "export HADOOP_HOME=/home/ubuntu/hadoop/" >> /home/ubuntu/.bashrc
RUN echo "ssh-keyscan -H localhost >> /home/ubuntu/.ssh/known_hosts" >> /home/ubuntu/.bashrc
RUN echo "ssh-keyscan -H 0.0.0.0 >> /home/ubuntu/.ssh/known_hosts" >> /home/ubuntu/.bashrc
RUN echo "ssh-keyscan -H 127.0.0.1 >> /home/ubuntu/.ssh/known_hosts" >> /home/ubuntu/.bashrc
RUN echo "cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys" >> /home/ubuntu/.bashrc
RUN tar xvf pig-*.tar.gz >/dev/null && rm pig-*.tar.gz && mv pig-* pig
RUN mv nolog.conf /home/ubuntu/pig/conf/ && mv /home/ubuntu/pig/bin/pig /home/ubuntu/pig/bin/pig.orig && mv pig.sh /home/ubuntu/pig/bin/pig
RUN echo 'export PATH=$PATH:~/pig/bin' >> ~/.bashrc 

