#!/bin/bash


sudo apt-get install -y nano time git openjdk-8-jdk-headless openssh-server make python 
sudo apt clean
# && rm -rf /var/lib/apt/lists/* && apt clean

cat /dev/zero | ssh-keygen -t rsa -q -N ""
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts
ssh-keyscan -H 127.0.0.1 >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
tar xvf hadoop-*.tar.gz >/dev/null && rm hadoop-*.tar.gz && mv hadoop-* hadoop
mkdir -p ~/hadoop/data/namenode
mkdir -p ~/hadoop/data/datanode
cat hadoop_env.header | cat - ~/hadoop/etc/hadoop/hadoop-env.sh > /tmp/out && mv /tmp/out ~/hadoop/etc/hadoop/hadoop-env.sh
cp core-site.xml ~/hadoop/etc/hadoop/core-site.xml
cp hdfs-site.xml ~/hadoop/etc/hadoop/hdfs-site.xml
cp yarn-site.xml ~/hadoop/etc/hadoop/yarn-site.xml
cp mapred-site.xml ~/hadoop/etc/hadoop/mapred-site.xml
echo 'export PATH=$PATH:~/hadoop/bin:~/hadoop/sbin' >> ~/.bashrc
~/hadoop/bin/hdfs namenode -format
rm *.xml hadoop_env.header
echo "sudo service ssh restart" >> ~/.bashrc
echo 'export JAVA_HOME=`dirname $(readlink /etc/alternatives/java)`/../' >> ~/.bashrc
echo "export HADOOP_HOME=~/hadoop/" >> ~/.bashrc
echo "ssh-keyscan -H localhost >> ~/.ssh/known_hosts" >> ~/.bashrc
echo "ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts" >> ~/.bashrc
echo "ssh-keyscan -H 127.0.0.1 >> ~/.ssh/known_hosts" >> ~/.bashrc
echo "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys" >> ~/.bashrc
tar xvf pig-*.tar.gz >/dev/null && rm pig-*.tar.gz && mv pig-* pig
mv nolog.conf ~/pig/conf/ && mv ~/pig/bin/pig ~/pig/bin/pig.orig && mv pig.sh ~/pig/bin/pig
echo 'export PATH=$PATH:~/pig/bin' >> ~/.bashrc

