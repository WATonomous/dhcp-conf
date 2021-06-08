#!/bin/sh

TYPE=${1:-primary}

if ! command -v docker &> /dev/null
then
	echo "------ docker not found, installing docker"
	apk add docker
fi

service docker --ifstopped start

echo "------ starting $TYPE DHCP server"

docker run -it --rm --init --net host -v "$(pwd)/data-$TYPE":/data -v "$(pwd)/data-shared":/shared networkboot/dhcpd eth1
