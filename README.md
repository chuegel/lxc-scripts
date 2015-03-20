# Purpose

Various scripts for lxc container management

## lxc_backup.sh

This script takes a snapshot of an existing container and creates a backup container from it. The backup container can be easliy exported to another machine running lxc.

### What does the script do?

1. checks if the container is running. If the container is running the script will stop the container. 
2. takes a snapshot (snap0) of the original container
3. creates a new (backup) container from snap0
4. deletes snap0 

### Usage

Invoke the script with `lxc_backup.sh <container name>` 

### TODO

* check if the provided container name exists
* update rootfs path in config file
* check if repocache is used and fix the path in config file
* TAR the backup container for easy exporting