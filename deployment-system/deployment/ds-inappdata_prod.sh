#!/bin/bash


# clearup broken rc before deployment starting

BROCKEN_RC=`/opt/bin/kubectl get rc --namespace=ds-production |grep deepshare2-inappdata- |awk '{print $1}'`

if [ "$BROCKEN_RC" != " " ]; then
         /opt/bin/kubectl delete rc/$BROCKEN_RC  --namespace=ds-production
else
    exit 0
fi

LAST_VERSION=`curl -s -S 'https://r.fds.so:5000/v2/ds-inappdata/tags/list' | /home/core/deployment/jq '."tags"[]' |sort -n |tail -1 | tr  -d '"'`
CURRENT_VERSION=$(date +%Y%m%d%H%M)

if [ $CURRENT_VERSION == $LAST_VERSION ]; then
	  /opt/bin/kubectl rolling-update deepshare2-inappdata  --image=r.fds.so:5000/ds-inappdata:"$CURRENT_VERSION" --namespace=ds-production & \
	  
else
          /opt/bin/kubectl rolling-update deepshare2-inappdata  --image=r.fds.so:5000/ds-inappdata:"$LAST_VERSION" --namespace=ds-production &  \
fi
