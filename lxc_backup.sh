#!/bin/bash

LXCSHUTDOWN='/usr/bin/lxc-stop'
LXCSTART='/usr/bin/lxc-start'
LXCSNAP='/usr/bin/lxc-snapshot'
LXCWAIT='/usr/bin/lxc-wait'
LXCLS='/usr/bin/lxc-ls -f'
LXCINFO='/usr/bin/lxc-info'

if [ -z $1 ]
then
   echo "Please call $0 <name of the container> you wish to backup"
  exit 1
fi

CONTAINER=$1
CONTAINERBACKUP=$CONTAINER"-backup"


function stopcontainer {
    echo "$CONTAINER is running. Let´s stop original container"
    $LXCSHUTDOWN -n $CONTAINER
    $LXCWAIT -n $CONTAINER -s 'STOPPED'
}

function startcontainer {
    echo "Let´s fire up original container..."
    $LXCSTART -n $CONTAINER -d
    $LXCWAIT -n $CONTAINER -s 'RUNNING'
}

function snapcontainer {
    echo "Creating s snapshot of $CONTAINER..."
    $LXCSNAP -n $CONTAINER
    echo "Creating $CONTAINERBACKUP from snapshot..."
    $LXCSNAP -n $CONTAINER -r snap0 $CONTAINERBACKUP

}

function delsnapshot {
    echo "Removing snapshot..."
    $LXCSNAP -n $CONTAINER -d snap0
}


# check if the container is running
STATE=`"$LXCINFO" -n "$CONTAINER" | grep State | awk {'print $2'}`
if [ "$STATE" == "RUNNING" ]
  then
    stopcontainer
    snapcontainer
    startcontainer
    delsnapshot
      elif [ "$STATE" == "STOPPED" ]
      then
       snapcontainer
       startcontainer
       delsnapshot
fi


$LXCLS
