#!/bin/bash



VERSION=$(date +%Y%m%d%H%M)

CODE_DIR=/mnt/staging/deepstats
REPOSITORY_ADDR=r.fds.so:5000

cd $CODE_DIR; echo "CMD /go/src/github.com/MISingularity/deepshare2/deepstatsd-api" >> Dockerfile_deepstats
cd $CODE_DIR;  sudo docker build -f Dockerfile_deepstats  -t  $REPOSITORY_ADDR/deepstats-api-staging:$VERSION .


DS2_VERSION=`sudo docker images |grep deepstats-api-staging |awk '{print $2}'|sort -n |tail -1`


if [ "$DS2_VERSION" == "$VERSION" ]; then
        sudo docker push $REPOSITORY_ADDR/deepstats-api-staging:$VERSION
else
        echo false
fi




# scallout pods
ssh -p 2201 core@fds.so -C 'bash  /home/core/deployment/deepstats_api_staging.sh'
