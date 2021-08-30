#!/bin/bash

USERNAME=
PORT=8080
COMPANY=coderz
DOCKER_IMAGE=coderz
DOCKER_USER=coderz
while getopts ":u:p:c:d:" opt; do
  case $opt in
    u) USERNAME="$OPTARG"
    ;;
    c) COMPANY="$OPTARG"
    ;;
	p) PORT="$OPTARG"
    ;;
	d) DOCKER_IMAGE="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" && exit 0
    ;;
  esac
done

if [[ -z "$USERNAME" ]] ; then
    echo 'What is the new username?'
	read USERNAME
fi

USERDIR=$PWD/devs/$USERNAME
cp -R "$PWD/devs/base/" "$USERDIR"

ssh-keygen -t rsa -b 4096 -C "$USERNAME@$COMPANY" -f "$USERDIR/ssh/id_rsa" -N ""

chmod 0600 "$USERDIR/ssh/id_rsa"

echo "docker run -it -d -p $PORT:8080 --name coderz-$USERNAME -v \"$USERDIR/projects:/home/$DOCKER_USER/projects\" -v \"$USERDIR/config:/home/$DOCKER_USER/.config\" -v \"$USERDIR/ssh:/home/$DOCKER_USER/.ssh\" $DOCKER_IMAGE" > docker-$USERNAME.sh

chmod +x docker-$USERNAME.sh



