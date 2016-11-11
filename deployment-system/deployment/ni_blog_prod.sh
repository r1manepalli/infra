#!/bin/bash

URRENT_VERSION=`/opt/bin/kubectl get pods -o yaml --namespace=ni-production  |grep -B 3 blog   |grep image |grep jekyll |head -1 |awk -F':' '{print $4}'`


if [ "$CURRENT_VERSION" == 1 ]; then
        /opt/bin/kubectl rolling-update  singularity-blog  --image=r.fds.so:5000/jekyll:2  --namespace=ni-production
else
        /opt/bin/kubectl rolling-update  singularity-blog  --image=r.fds.so:5000/jekyll:1  --namespace=ni-production
fi
