VERSION=2.7.6
SHARE=share
NAME=hadoop

all:	build-share run
	

build-share:
	mkdir -p ${SHARE}

run:
	sudo docker run -ti --rm --name=${NAME} -p 8088:8088 -p 50070:50070 -v `pwd`/${SHARE}:/home/ubuntu/share -h ubuntu ${NAME}-${VERSION}

clean:
	sudo docker rm ${NAME}-${VERSION}

build:
	-sudo docker rmi ${NAME}-${VERSION}
	sudo docker build -t ${NAME}-${VERSION} -f Dockerfile .
