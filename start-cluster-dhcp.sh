#!/bin/sh

TYPE=${1:-primary}

if ! command -v docker &> /dev/null; then
	echo "------ docker not found, installing docker"
	apk add docker
fi

if ! service docker status | grep started &> /dev/null; then
	echo "------ starting docker service"
	service docker start
	sleep 3
fi

if ! rc-update | grep docker &> /dev/null; then
	echo "------ adding docker to startup services list"
	rc-update add docker boot
fi

echo "------ starting $TYPE DHCP server"

docker run -d --restart always --name dhcp --init --net host -v "$(pwd)/data-$TYPE":/data -v "$(pwd)/data-shared":/shared networkboot/dhcpd eth1

