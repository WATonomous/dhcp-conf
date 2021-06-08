#!/bin/sh

TYPE=${1:-primary}

if ! command -v docker &> /dev/null; then
	echo "------ docker not found, installing docker"
	apk add docker
fi

if ! service docker status | grep started; then
	echo "------ starting docker service"
	service docker start
	sleep 3
fi

echo "------ starting $TYPE DHCP server"

docker run -it --rm --init --net host -v "$(pwd)/data-$TYPE":/data -v "$(pwd)/data-shared":/shared networkboot/dhcpd eth1
