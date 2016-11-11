#!/bin/bash



VERSION=$(date +%Y%m%d%H%M)

CODE_DIR=/mnt/prod/deepshare2
REPOSITORY_ADDR=r.fds.so:5000

cd $CODE_DIR;  sudo docker build -f Dockerfile_collectua -t  $REPOSITORY_ADDR/deepshare2-collectua:$VERSION .


DS2_VERSION=`sudo docker images |grep deepshare2-collectua |awk '{print $2}'|sort -n |tail -1`


if [ "$DS2_VERSION" == "$VERSION" ]; then
        sudo docker push $REPOSITORY_ADDR/deepshare2-collectua:$VERSION
else
        echo false
fi




# scallout pods
ssh -p 2201 core@fds.so -C 'bash  /home/core/deployment/deepshare2_collectua_production.sh'