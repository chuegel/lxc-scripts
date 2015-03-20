# Purpose

Various scripts for lxc container management

## lxc_backup.sh

This script takes a snapshot of an existing container and creates a backup container from it.

### Usage

Invoke the script with `lxc_backup.sh <container name>` 

### TODO

* check if the provided container name exists
* TAR the backup container for easy exporting