# Ubuntu 16.04 + Apache Hadoop 2.7.6 + Apache Pig 0.15

## Fetch the docker container
```
> docker pull ercoppa/hadoop-2.7.6
```
Then start the container with:
```
> make 
```
Start Apache Hadoop with:
```
> ./start.sh
```

## Install directly on your host
The script `install.sh` can be used to install Apache Hadoop 2.7.6 and Apache Pig 0.15 on Ubuntu 16.04. 
Just run:
```
> ./install.sh
```
Start Apache Hadoop with:
```
> start-all.sh
```
