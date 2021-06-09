# WATO DHCP Server

## Getting Started

To start a set of primary-secondary DHCP servers (2 for failover).

1. Prepare 2 lxc containers on Proxmox. Give each 2 network devices (vmbr2 - NAT, vmbr1 - Cluster). Set one device's Cluster IP address to `10.0.50.200` and the other to `10.0.50.201`. Subnetmask is `255.255.255.0`.
1. Clone this repo to both containers.
1. Run `./start-cluster-dhcp.sh primary` in the `10.0.50.200` container. Run `./start-cluster-dhcp.sh secondary` in the `10.0.50.201` container.

