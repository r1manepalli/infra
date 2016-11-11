#!/bin/bash

VERSION=$(date +%Y%m%d%H%M)
CODE_DIR=/mnt/prod/deepstats-retention-days
REPOSITORY_ADDR=r.fds.so:5000

cd $CODE_DIR; echo "CMD /go/src/github.com/MISingularity/deepshare2/deepstatsd-retention" >> Dockerfile_deepstats
cd $CODE_DIR;  sudo docker build -f Dockerfile_deepstats  -t  $REPOSITORY_ADDR/deepstats-retention-days:$VERSION .


DS2_VERSION=`sudo docker images |grep deepstats-retention-days |awk '{print $2}'|sort -n |tail -1`


if [ "$DS2_VERSION" == "$VERSION" ]; then
        sudo docker push $REPOSITORY_ADDR/deepstats-retention-days:$VERSION
else
        echo false
fi




# scallout pods
ssh -p 2201 core@fds.so -C 'bash  /home/core/deployment/deepstats-retention-days_production.sh'
